import traceback
from datetime import datetime
from flask import Blueprint, jsonify, request
from flask_jwt_extended import verify_jwt_in_request, get_jwt
from main.database import Session
from biblio.models import Order, OrderItem
from sqlalchemy.orm import joinedload

api = Blueprint('cafe_apis_orders', __name__)

def _resolve_user_id(payload):
  user_id = None
  try:
    verify_jwt_in_request(optional=True)
    claims = get_jwt()
    user_id = claims.get('user_id')
  except Exception:
    pass

  if user_id is None and payload:
    try:
      if isinstance(payload, dict):
        user_id = payload.get('user_id')
    except Exception:
      user_id = None

  return user_id or 1

@api.route('/apis/v1/orders', methods=['POST'])
def create_order():
  response = None
  status = 201
  data = request.get_json()

  if not data or 'items' not in data or len(data['items']) == 0:
    return jsonify({
      'message': 'Debe enviar al menos un item',
      'data': None,
      'success': False,
      'error': 'Bad Request'
    }), 400

  user_id = _resolve_user_id(data)
  requested_status = (data.get('status') or 'pendiente').lower()
  valid_statuses = ['pendiente', 'preparando', 'listo', 'recogido', 'cancelado']
  status_value = requested_status if requested_status in valid_statuses else 'pendiente'

  session = Session()
  try:
    total = 0
    order_items = []
    for item in data['items']:
      subtotal = item['unit_price'] * item['quantity']
      total += subtotal
      order_items.append(OrderItem(
        product_id=item['product_id'],
        size=item.get('size', ''),
        sugar=item.get('sugar', ''),
        extras=','.join(item.get('extras', [])),
        unit_price=item['unit_price'],
        quantity=item['quantity']
      ))

    order = Order(
      user_id=user_id,
      total=total,
      status=status_value,
      created_at=datetime.now()
    )
    session.add(order)
    session.flush()

    for oi in order_items:
      oi.order_id = order.id
      session.add(oi)

    session.commit()

    order = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(Order.id == order.id).first()

    response = jsonify({
      'message': 'Orden creada exitosamente',
      'data': order.to_dict(),
      'success': True,
      'error': None
    })
  except Exception as e:
    session.rollback()
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al crear la orden',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status

@api.route('/apis/v1/orders', methods=['GET'])
def fetch_my_orders():
  response = None
  status = 200
  user_id = _resolve_user_id(None)
  session = Session()
  try:
    orders = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(
      Order.user_id == user_id
    ).order_by(Order.created_at.desc()).all()

    response = jsonify({
      'message': 'Mis órdenes',
      'data': [o.to_dict() for o in orders],
      'success': True,
      'error': None
    })
  except Exception as e:
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al listar órdenes',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status

@api.route('/apis/v1/orders/<int:id>', methods=['GET'])
def fetch_by_id(id):
  response = None
  status = 200
  user_id = _resolve_user_id(None)
  session = Session()
  try:
    order = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(
      Order.id == id,
      Order.user_id == user_id
    ).first()

    if order:
      response = jsonify({
        'message': 'Orden encontrada',
        'data': order.to_dict(),
        'success': True,
        'error': None
      })
    else:
      response = jsonify({
        'message': 'Orden no encontrada',
        'data': None,
        'success': False,
        'error': 'Not Found'
      })
      status = 404
  except Exception as e:
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al buscar orden',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status

@api.route('/apis/v1/orders/<int:id>/status', methods=['PUT'])
def update_order_status(id):
  response = None
  status = 200
  data = request.get_json()

  if not data or 'status' not in data:
    return jsonify({
      'message': 'Debe proporcionar un estado',
      'data': None,
      'success': False,
      'error': 'Bad Request'
    }), 400

  user_id = _resolve_user_id(data)
  session = Session()
  try:
    order = session.query(Order).filter(
      Order.id == id,
      Order.user_id == user_id
    ).first()

    if not order:
      return jsonify({
        'message': 'Orden no encontrada',
        'data': None,
        'success': False,
        'error': 'Not Found'
      }), 404

    valid_statuses = ['pendiente', 'preparando', 'listo', 'recogido', 'cancelado']
    new_status = data['status'].lower()

    if new_status not in valid_statuses:
      return jsonify({
        'message': f'Estado inválido. Válidos: {", ".join(valid_statuses)}',
        'data': None,
        'success': False,
        'error': 'Bad Request'
      }), 400

    order.status = new_status
    session.commit()

    order = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(Order.id == order.id).first()

    response = jsonify({
      'message': f'Orden actualizada a {new_status}',
      'data': order.to_dict(),
      'success': True,
      'error': None
    })
  except Exception as e:
    session.rollback()
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al actualizar orden',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status

@api.route('/apis/v1/orders/<int:id>/status', methods=['PUT'])
@jwt_required
def update_order_status(id):
  response = None
  status = 200
  data = request.get_json()
  
  if not data or 'status' not in data:
    return jsonify({
      'message': 'Debe proporcionar un estado',
      'data': None,
      'success': False,
      'error': 'Bad Request'
    }), 400

  session = Session()
  try:
    order = session.query(Order).filter(
      Order.id == id,
      Order.user_id == g.user_id
    ).first()

    if not order:
      return jsonify({
        'message': 'Orden no encontrada',
        'data': None,
        'success': False,
        'error': 'Not Found'
      }), 404

    # Actualizar estado
    valid_statuses = ['pendiente', 'preparando', 'listo', 'recogido', 'cancelado']
    new_status = data['status'].lower()
    
    if new_status not in valid_statuses:
      return jsonify({
        'message': f'Estado inválido. Válidos: {", ".join(valid_statuses)}',
        'data': None,
        'success': False,
        'error': 'Bad Request'
      }), 400

    order.status = new_status
    session.commit()

    # Recargar con relaciones
    order = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(Order.id == order.id).first()

    response = jsonify({
      'message': f'Orden actualizada a {new_status}',
      'data': order.to_dict(),
      'success': True,
      'error': None
    })
  except Exception as e:
    session.rollback()
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al actualizar orden',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status