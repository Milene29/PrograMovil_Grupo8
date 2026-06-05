import 'package:flutter/material.dart';
import '../../services/mock_user_service.dart';
import '../menu/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController codigoController =
      TextEditingController();

  final MockUserService _userService =
      MockUserService();

  Future<void> iniciarSesion() async {

    final codigo =
        codigoController.text.trim();

    if (codigo.isEmpty) {
      mostrarMensaje(
        'Ingrese su código universitario.',
      );
      return;
    }

    try {

      final usuario =
          await _userService.obtenerUsuario(
        codigo,
      );

      if (usuario != null) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MenuPage(
              usuarioNombre:
                  usuario['nombre'],
            ),
          ),
        );

      } else {

        mostrarMensaje(
          'El código universitario no está registrado.',
        );

      }

    } catch (e) {

      mostrarMensaje(
        'Error al leer usuarios_mock.json\n\n$e',
      );

    }
  }

  void mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ULima Café'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(
                top: 40,
                bottom: 40,
                left: 24,
                right: 24,
              ),
              decoration:
                  const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF9A0036),
                    Color(0xFF7A002C),
                  ],
                ),
              ),
              child: Row(
                children: [

                  Container(
                    width: 70,
                    height: 70,
                    decoration:
                        BoxDecoration(
                      color: Colors.white
                          .withAlpha(40),
                      shape:
                          BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school,
                      color:
                          Colors.white,
                      size: 35,
                    ),
                  ),

                  const SizedBox(
                      width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          'ULima Café',
                          style:
                              TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                                28,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        SizedBox(
                            height: 4),
                        Text(
                          'Universidad de Lima',
                          style:
                              TextStyle(
                            color: Colors
                                .white70,
                            fontSize:
                                16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                        24),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    const SizedBox(
                        height: 20),

                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    const Text(
                      'Ingresa con tu código universitario para realizar pedidos.',
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            Colors.grey,
                      ),
                    ),

                    const SizedBox(
                        height: 50),

                    const Text(
                      'Código Universitario',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    TextField(
                      controller:
                          codigoController,
                      keyboardType:
                          TextInputType
                              .number,
                      decoration:
                          InputDecoration(
                        hintText:
                            'Ej. 20203263',
                        filled: true,
                        fillColor:
                            Colors.white,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      18),
                        ),
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 60,
                      child:
                          ElevatedButton(
                        onPressed:
                            iniciarSesion,
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              const Color(
                                  0xFFB77B90),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    30),
                          ),
                        ),
                        child:
                            const Text(
                          'Ingresar',
                          style:
                              TextStyle(
                            fontSize:
                                22,
                            color: Colors
                                .white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}