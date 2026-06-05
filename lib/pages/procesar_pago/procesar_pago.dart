import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pagar_qr.dart'; // Ajusta la ruta según tu proyecto

class ConfirmarPedidoPage extends StatelessWidget {
  const ConfirmarPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmarPedidoController());
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Confirmar pedido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductRow(),
              const SizedBox(height: 24),
              const Text(
                '¿Cuándo lo recoges?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              _buildTimeOptions(controller),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Programar',
                    'Funcionalidad en desarrollo',
                    backgroundColor: Colors.white,
                    colorText: const Color(0xFF7A0C2E),
                  );
                },
                child: const Text(
                  'Programar',
                  style: TextStyle(color: Color(0xFF7A0C2E)),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Método de pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              _buildPaymentMethods(controller),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'Pagos cifrados de extremo a extremo',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.aceptaServicio.value) {
                      Get.snackbar(
                        'Aviso',
                        'Debes aceptar el servicio para continuar',
                        backgroundColor: Colors.white,
                        colorText: const Color(0xFF7A0C2E),
                      );
                      return;
                    }
                    Get.to(() => const PagarQRPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A0C2E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmar y pagar · S/ 5.50',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '1 producto',
            style: TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Detalle',
                'Aquí iría el detalle del producto',
                backgroundColor: Colors.white,
                colorText: const Color(0xFF7A0C2E),
              );
            },
            child: const Text(
              'Ver detalle',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7A0C2E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            'S/ 5.50',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOptions(ConfirmarPedidoController controller) {
    final List<Map<String, String>> options = [
      {'title': 'Lo antes posible', 'subtitle': '≈ 15 min'},
      {'title': 'En 30 min', 'subtitle': 'Recoge más tarde'},
      {'title': 'En 1 hora', 'subtitle': 'Para luego'},
    ];
    return Row(
      children: options.map((option) {
        final isSelected = controller.tiempoSeleccionado.value == option['title'];
        return GestureDetector(
          onTap: () => controller.tiempoSeleccionado.value = option['title']!,
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF7A0C2E) : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected ? const Color(0xFF7A0C2E) : Colors.grey.shade300,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  option['title']!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  option['subtitle']!,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Colors.white70 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentMethods(ConfirmarPedidoController controller) {
    final List<Map<String, dynamic>> methods = [
      {'icon': Icons.qr_code_scanner, 'title': 'Pago con QR', 'subtitle': 'Billeteras digitales'},
      {'icon': Icons.apple, 'title': 'Apple Pay', 'subtitle': 'Pago con Face ID'},
      {'icon': Icons.credit_card, 'title': 'Google Pay', 'subtitle': 'Pago instantáneo'},
    ];

    return Column(
      children: methods.asMap().entries.map((entry) {
        final index = entry.key;
        final method = entry.value;
        final isSelected = controller.metodoPagoIndex.value == index;
        final String title = method['title'] as String;
        final String? subtitle = method['subtitle'] as String?;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF7A0C2E) : Colors.grey.shade200,
            ),
          ),
          child: ListTile(
            leading: Icon(
              method['icon'] as IconData,
              color: isSelected ? const Color(0xFF7A0C2E) : Colors.grey.shade600,
            ),
            title: Text(title),
            subtitle: subtitle != null
                ? Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12),
                  )
                : null,
            trailing: isSelected
                ? const Icon(Icons.radio_button_checked, color: Color(0xFF7A0C2E))
                : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
            onTap: () => controller.metodoPagoIndex.value = index,
          ),
        );
      }).toList(),
    );
  }
}

class ConfirmarPedidoController extends GetxController {
  var tiempoSeleccionado = 'Lo antes posible'.obs;
  var metodoPagoIndex = 0.obs;
  var aceptaServicio = true.obs;
}