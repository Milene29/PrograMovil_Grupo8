import traceback
from flask import Blueprint, jsonify, request
from main.database import Session
from cafe.models import User
from flask_jwt_extended import create_access_token

api = Blueprint('cafe_apis_users', __name__)

@api.route('/apis/v1/users/login', methods=['POST'])
def login():
    data = request.get_json()

    if not data:
        return jsonify({
            'message': 'Debe enviar un JSON válido',
            'data': None,
            'success': False,
            'error': 'Bad Request'
        }), 400

    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({
            'message': 'username y password son obligatorios',
            'data': None,
            'success': False,
            'error': 'Missing required fields'
        }), 400

    session = Session()
    try:
        user = (
            session.query(User)
            .filter(
                User.username == username,
                User.password == password
            )
            .first()
        )

        if not user:
            return jsonify({
                'message': 'Usuario o contraseña incorrectos',
                'data': None,
                'success': False,
                'error': 'Unauthorized'
            }), 401

        jwt = create_access_token(
            identity=username,
            additional_claims={
                "user_id": user.id
            }
        )

        return jsonify({
            'message': 'Login exitoso',
            'data': {
                'user': user.to_dict(),
                'jwt': jwt
            },
            'success': True,
            'error': None
        }), 200

    except Exception as e:
        traceback.print_exc()
        return jsonify({
            'message': 'Error durante el login',
            'data': None,
            'success': False,
            'error': str(e)
        }), 500
    finally:
        session.close()