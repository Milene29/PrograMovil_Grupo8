import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/login/login_page.dart';
import 'pages/menu/menu_page.dart';
import 'pages/pickup_order/pickup_order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ulima Café',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A0C2E),
          primary: const Color(0xFF7A0C2E),
          secondary: const Color(0xFF7A0C2E),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7A0C2E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: LoginPage(),
    );
  }
}
