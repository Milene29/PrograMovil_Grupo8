import traceback
from flask import Blueprint, jsonify
from biblio.models import Category
from main.database import Session

api = Blueprint('cafe_apis_categories', __name__)

@api.route('/apis/v1/categories', methods=['GET'])
def fetch_all():
  response = None
  status = 200
  session = Session()
  try:
    categories = session.query(Category).all()
    response = jsonify({
      'message': 'Lista de categorías',
      'data': [c.to_dict() for c in categories],
      'success': True,
      'error': None
    })
  except Exception as e:
    traceback.print_exc()
    response = jsonify({
      'message': 'Error al listar categorías',
      'error': str(e),
      'data': None,
      'success': False
    })
    status = 500
  finally:
    session.close()
  return response, status