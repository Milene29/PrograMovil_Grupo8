import 'package:get/get.dart';
import '../../models/pickup_order.dart';
import '../carrito/cart_controller.dart';

class PickupOrderController extends GetxController {
  
  final CartController _cartController = Get.find<CartController>();

  late final Rx<PickupOrder> order;

  @override
  void onInit() {
    super.onInit();
    // Construir la orden con los datos del carrito
    _initializeOrder();
  }

  void _initializeOrder() {
    // Convertir los CartEntry a datos para la orden
    final items = _cartController.entries.map((entry) {
      return {
        "name": entry.product.name,
        "quantity": entry.quantity.value,
        "price": entry.total,
        "size": entry.selectedSize,
        "sugar": entry.selectedSugar,
        "extras": entry.selectedExtras,
      };
    }).toList();

    order = PickupOrder(
      orderNumber: 'A${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      status: 'Listo para recoger',
      total: _cartController.subtotal,
      remainingMinutes: 5,
      items: items,
    ).obs;
  }

  // Obtener los productos del carrito en tiempo real
  List<Map<String, dynamic>> get products {
    return _cartController.entries.map((entry) {
      return {
        "name": entry.product.name,
        "quantity": entry.quantity.value,
        "price": entry.total,
        "size": entry.selectedSize,
        "sugar": entry.selectedSugar,
        "extras": entry.selectedExtras,
      };
    }).toList();
  }

  // Obtener el total del carrito en tiempo real
  double get totalPrice => _cartController.subtotal;
}