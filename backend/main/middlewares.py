from functools import wraps
from flask import request, jsonify, g
from flask_jwt_extended import (
    verify_jwt_in_request,
    get_jwt,
    get_jwt_identity
)

def jwt_required(fn):
  @wraps(fn)
  def wrapper(*args, **kwargs):
    try:
      verify_jwt_in_request()

      claims = get_jwt()

      if not claims.get("user_id"):
        return jsonify({
          "message": "Token inválido",
          "data": None,
          "success": False,
          "error": "Missing user_id claim"
        }), 401
        
      # extraer datos del jwt para usarlos en el endpoint
      g.user_id = claims.get("user_id")
      g.username = get_jwt_identity()

      return fn(*args, **kwargs)

    except Exception as e:
      return jsonify({
        "message": "Token inválido o expirado",
        "data": None,
        "success": False,
        "error": str(e)
      }), 401

  return wrapper

def not_found(e):
  return jsonify({
    "message": "Recurso no encontrado",
    "data": None,
    "success": False,
    "error": "Not Found"
  }), 404