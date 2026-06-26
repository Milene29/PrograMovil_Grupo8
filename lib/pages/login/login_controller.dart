import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/menu/menu_page.dart';
import '../../services/auth_service.dart';

class LoginController extends GetxController {
  final TextEditingController codigoController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool mostrarPassword = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> validarCodigo() async {
    final codigo = codigoController.text.trim();

    if (codigo.isEmpty) {
      _mostrarDialogo(
        titulo: 'Código requerido',
        mensaje: 'Ingrese su código universitario.',
      );
      return;
    }

    final existe = await AuthService.validarCodigo(codigo);

    if (!existe) {
      _mostrarDialogo(
        titulo: 'Acceso denegado',
        mensaje: 'El código universitario no existe.',
      );
      return;
    }

    mostrarPassword.value = true;
  }

  Future<void> iniciarSesion() async {
    final codigo = codigoController.text.trim();
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      _mostrarDialogo(
        titulo: 'Contraseña requerida',
        mensaje: 'Ingrese su contraseña.',
      );
      return;
    }

    final response = await AuthService.login(
      codigo: codigo,
      password: password,
    );

    if (response == null) {
      _mostrarDialogo(
        titulo: 'Error',
        mensaje: 'Usuario o contraseña incorrectos.',
      );
      return;
    }

    final user = response['data']['user'];

    Get.offAll(
      () => MenuPage(
        usuarioNombre:
            "${user['first_name']} ${user['last_name']}",
      ),
    );
  }

  void reiniciarLogin() {
    mostrarPassword.value = false;
    passwordController.clear();
  }

  void _mostrarDialogo({
    required String titulo,
    required String mensaje,
  }) {
    Get.defaultDialog(
      title: titulo,
      middleText: mensaje,
      textConfirm: 'Aceptar',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF9A0036),
      onConfirm: () => Get.back(),
    );
  }

  @override
  void onClose() {
    codigoController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}