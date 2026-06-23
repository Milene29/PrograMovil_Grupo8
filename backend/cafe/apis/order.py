import traceback
from datetime import datetime
from flask import Blueprint, jsonify, request, g
from main.middlewares import jwt_required
from biblio.models import Order, OrderItem
from main.database import Session
from sqlalchemy.orm import joinedload

api = Blueprint('cafe_apis_orders', __name__)

@api.route('/apis/v1/orders', methods=['POST'])
@jwt_required
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

  session = Session()
  try:
    # Calcular total desde los items
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

    # Crear orden
    order = Order(
      user_id=g.user_id,
      total=total,
      status='pendiente',
      created_at=datetime.now()
    )
    session.add(order)
    session.flush()  # Para obtener el ID de la orden

    # Asignar order_id a cada item
    for oi in order_items:
      oi.order_id = order.id
      session.add(oi)

    session.commit()

    # Recargar con relaciones
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
@jwt_required
def fetch_my_orders():
  response = None
  status = 200
  session = Session()
  try:
    orders = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(
      Order.user_id == g.user_id
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
@jwt_required
def fetch_by_id(id):
  response = None
  status = 200
  session = Session()
  try:
    order = session.query(Order).options(
      joinedload(Order.items).joinedload(OrderItem.product)
    ).filter(
      Order.id == id,
      Order.user_id == g.user_id
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