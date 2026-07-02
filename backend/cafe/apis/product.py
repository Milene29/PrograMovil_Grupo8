import traceback
from flask import Blueprint, jsonify, request
from cafe.models import Product
from main.database import Session
from sqlalchemy.orm import joinedload

api = Blueprint('cafe_apis_products', __name__)

@api.route('/apis/v1/products', methods=['GET'])
def fetch_all():
  response = None
  status = 200
  session = Session()
  try:
    query = session.query(Product).options(joinedload(Product.category))

    # Filtro opcional por categoría
    category_id = request.args.get('category_id')
    if category_id:
      query = query.filter(Product.category_id == int(category_id))

    # Filtro opcional por recomendados
    recommended = request.args.get('recommended')
    if recommended == 'true':
      query = query.filter(Product.is_recommended == True)

    products = query.all()
    response = jsonify({
      'message': 'Lista de productos',
      'data': [p.to_dict() for p in products],
      'success': True,
      'error': None
    })
  except Exception as e:
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al listar productos',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status

@api.route('/apis/v1/products/<int:id>', methods=['GET'])
def fetch_by_id(id):
  response = None
  status = 200
  session = Session()
  try:
    product = session.query(Product).options(
      joinedload(Product.category)
    ).filter(Product.id == id).first()

    if product:
      response = jsonify({
        'message': 'Producto encontrado',
        'data': product.to_dict(),
        'success': True,
        'error': None
      })
    else:
      response = jsonify({
        'message': f'No se encontró el producto con ID {id}',
        'data': None,
        'success': False,
        'error': 'Not Found'
      })
      status = 404
  except Exception as e:
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al buscar producto',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status