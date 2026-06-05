import 'dart:convert';
import 'package:flutter/services.dart';

class MockUserService {
  Future<Map<String, dynamic>?> obtenerUsuario(
      String codigo) async {

    final String response =
        await rootBundle.loadString(
      'lib/data/usuarios_mock.json',
    );

    final List<dynamic> usuarios =
        json.decode(response);

    for (var usuario in usuarios) {
      if (usuario['codigo'] == codigo) {
        return usuario;
      }
    }

    return null;
  }
}