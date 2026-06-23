# !/usr/bin/env python
# -*- coding: utf-8 -*-
from flask import Flask, jsonify
from flask_jwt_extended import JWTManager
from flask_session import Session
from flask_cors import CORS
from datetime import timedelta

APP = Flask(
  __name__,
  static_folder='../static',
  static_url_path='/'
)

APP.config['SECRET_KEY'] = 'your_secret_key'
APP.config['SESSION_TYPE'] = 'filesystem'
APP.config['SESSION_PERMANENT'] = False
APP.config['SESSION_USE_SIGNER'] = True
APP.config['SESSION_KEY_PREFIX'] = 'session:'
APP.config['JWT_SECRET_KEY'] = 'd7e7c95f0fd3d4b9d4e6c55a3e2d65c2f77f3b9d6d2a1f4e8b8d9c6a7e5f3d2' 
APP.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=15)
Session(APP)
CORS(APP)

jwt = JWTManager(APP)

REVOKED_TOKENS = []

@jwt.token_in_blocklist_loader
def check_if_token_revoked(jwt_header, jwt_payload):
  jti = jwt_payload['jti']
  return jti in REVOKED_TOKENS

@jwt.unauthorized_loader
def unauthorized_response(callback):
  return jsonify({"error": "Acceso no autorizado. Debes proporcionar un token válido."}), 401

@jwt.expired_token_loader
def expired_token_response(jwt_header, jwt_payload):
  return jsonify({"error": "El token ha expirado. Por favor, inicia sesión nuevamente."}), 401

@jwt.invalid_token_loader
def invalid_token_response(reason):
  return jsonify({"error": "Token inválido o corrupto. Revisa tu autenticación."}), 401

@jwt.needs_fresh_token_loader
def needs_fresh_token_response(jwt_header, jwt_payload):
  return jsonify({"error": "Se requiere un token fresco. Vuelve a iniciar sesión."}), 401