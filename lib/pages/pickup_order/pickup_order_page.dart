import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../menu/menu_page.dart';
import '../carrito/cart_controller.dart';
import 'pickup_order_controller.dart';

class PickupOrderPage extends StatelessWidget {

  PickupOrderPage({super.key});

  final PickupOrderController controller =
      Get.put(PickupOrderController());

  static const Color primaryColor = Color(0xFF7A0C2E);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Recoger Pedido"),
      ),

      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildOrderCard(),

              const SizedBox(height: 20),

              _buildProgressCard(),

              const SizedBox(height: 20),

              _buildProductsCard(),

              const SizedBox(height: 20),

              _buildQrCard(),

              const SizedBox(height: 20),

              _buildLocationCard(),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Obtener el CartController y limpiar el carrito
                    final cartController = Get.find<CartController>();
                    cartController.clearCart();
                    
                    Get.snackbar(
                      "Pedido",
                      "Pedido recogido correctamente",
                      backgroundColor: Colors.white,
                      colorText: primaryColor,
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.offAll(() => MenuPage());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "YA RECOGÍ MI PEDIDO",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildOrderCard() {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Pedido #${controller.order.value.orderNumber}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            controller.order.value.status,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Total: S/ ${controller.totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [

              const Icon(
                Icons.access_time,
                color: Colors.white,
              ),

              const SizedBox(width: 8),

              Text(
                "${controller.order.value.remainingMinutes} min restantes",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProgressCard() {

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: const [

            ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text("Pedido confirmado"),
            ),

            ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text("En preparación"),
            ),

            ListTile(
              leading: Icon(
                Icons.radio_button_checked,
                color: Color(0xFF7A0C2E),
              ),
              title: Text("Listo para recoger"),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildProductsCard() {

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Detalle del Pedido",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            if (controller.products.isEmpty)
              Text(
                "No hay productos en este pedido",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              ...controller.products.map(
                (product) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${product["name"]} x${product["quantity"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "S/ ${product["price"].toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tamaño: ${product["size"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "Azúcar: ${product["sugar"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if ((product["extras"] as List).isNotEmpty)
                        Text(
                          "Extras: ${(product["extras"] as List).join(', ')}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      if (product != controller.products.last)
                        Divider(
                          color: Colors.grey.shade300,
                          height: 12,
                        ),
                    ],
                  ),
                ),
              ),

            const Divider(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TOTAL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "S/ ${controller.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrCard() {

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const Text(
              "Código de Recogida",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: 180,
              height: 180,

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),

              child: const Icon(
                Icons.qr_code,
                size: 120,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              controller.order.value.orderNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Muestra este código al recoger tu pedido",
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            Row(
              children: [

                Icon(
                  Icons.location_on,
                  color: Color(0xFF7A0C2E),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "Ulima Café\nPabellón A - Primer Piso",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 2,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.shade400,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == 0) {
          Get.offAll(() => MenuPage());
        }
        if (index == 1) {
          Get.snackbar(
            'Navegación',
            'Pantalla en desarrollo (Solo Front)',
            backgroundColor: Colors.white,
            colorText: primaryColor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        if (index == 2) {
          // Ya estamos en Órdenes/Pickup
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          activeIcon: Icon(Icons.shopping_bag),
          label: 'Carrito',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'Órdenes',
        ),
      ],
    );
  }
}