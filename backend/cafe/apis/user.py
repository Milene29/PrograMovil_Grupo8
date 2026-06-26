import traceback
from flask import Blueprint, jsonify, request
from main.database import Session
from biblio.models import User
from flask_jwt_extended import create_access_token

api = Blueprint('cafe_apis_users', __name__)


# ==========================================
# VALIDAR CÓDIGO
# ==========================================
@api.route('/apis/v1/users/validate-code', methods=['POST'])
def validate_code():

    data = request.get_json()

    if not data:
        return jsonify({
            'message': 'Debe enviar un JSON válido',
            'success': False
        }), 400

    codigo = data.get('codigo')

    if not codigo:
        return jsonify({
            'message': 'Debe enviar un código',
            'success': False
        }), 400

    session = Session()

    try:

        user = (
            session.query(User)
            .filter(User.username == codigo)
            .first()
        )

        if not user:
            return jsonify({
                'message': 'Código no encontrado',
                'success': False
            }), 404

        return jsonify({
            'message': 'Código válido',
            'success': True
        }), 200

    except Exception as e:

        traceback.print_exc()

        return jsonify({
            'message': str(e),
            'success': False
        }), 500

    finally:
        session.close()


# ==========================================
# LOGIN
# ==========================================
@api.route('/apis/v1/users/login', methods=['POST'])
def login():

    data = request.get_json()

    if not data:
        return jsonify({
            'message': 'Debe enviar un JSON válido',
            'success': False
        }), 400

    codigo = data.get('codigo')
    password = data.get('password')

    if not codigo or not password:
        return jsonify({
            'message': 'codigo y password son obligatorios',
            'success': False
        }), 400

    session = Session()

    try:

        user = (
            session.query(User)
            .filter(
                User.username == codigo,
                User.password == password
            )
            .first()
        )

        if not user:
            return jsonify({
                'message': 'Usuario o contraseña incorrectos',
                'success': False
            }), 401

        token = create_access_token(
            identity=str(user.id)
        )

        return jsonify({
            'message': 'Login exitoso',
            'success': True,
            'data': {
                'jwt': token,
                'user': user.to_dict()
            }
        }), 200

    except Exception as e:

        traceback.print_exc()

        return jsonify({
            'message': str(e),
            'success': False
        }), 500

    finally:
        session.close()