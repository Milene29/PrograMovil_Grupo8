import 'package:get/get.dart';
import '../../models/pickup_order.dart';
import '../../services/order_service.dart';
import '../carrito/cart_controller.dart';

class PickupOrderController extends GetxController {
  
  final CartController _cartController = Get.find<CartController>();
  final OrderService _orderService = OrderService();

  late final Rx<PickupOrder> order;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<int?> orderId = Rx<int?>(null);

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
        "product_id": entry.product.id,
        "name": entry.product.name,
        "quantity": entry.quantity.value,
        "price": entry.total,
        "unit_price": entry.unitPrice,
        "size": entry.selectedSize,
        "sugar": entry.selectedSugar,
        "extras": entry.selectedExtras,
      };
    }).toList();

    order = PickupOrder(
      orderNumber: 'A${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      status: 'pendiente',
      total: _cartController.subtotal,
      remainingMinutes: 5,
      items: items,
    ).obs;
  }

  /// Crear orden en el backend
  Future<void> createOrder() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Preparar items sin datos innecesarios
      final items = _cartController.entries.map((entry) {
        return {
          "product_id": entry.product.id,
          "quantity": entry.quantity.value,
          "unit_price": entry.unitPrice,
          "size": entry.selectedSize,
          "sugar": entry.selectedSugar,
          "extras": entry.selectedExtras,
        };
      }).toList();

      final response = await _orderService.createOrder(
        items: items,
        status: 'listo',
      );

      if (response.success && response.data != null) {
        final backendOrder = PickupOrder.fromJson(response.data!);
        order.value = backendOrder;
        orderId.value = backendOrder.id;
        
        Get.snackbar(
          'Éxito',
          'Orden creada exitosamente',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        errorMessage.value = response.error ?? 'Error al crear la orden';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Error inesperado: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Actualizar estado de la orden
  Future<void> updateOrderStatus(String newStatus) async {
    final id = orderId.value;
    if (id == null) {
      errorMessage.value = 'ID de orden no disponible';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _orderService.updateOrderStatus(
        orderId: id,
        status: newStatus,
      );

      if (response.success && response.data != null) {
        final updatedOrder = PickupOrder.fromJson(response.data!);
        order.value = updatedOrder;
        
        Get.snackbar(
          'Éxito',
          'Orden actualizada a: $newStatus',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        errorMessage.value = response.error ?? 'Error al actualizar la orden';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Error inesperado: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Obtener estado actual de la orden
  Future<void> fetchOrderStatus() async {
    final id = orderId.value;
    if (id == null) return;

    isLoading.value = true;

    try {
      final response = await _orderService.getOrderById(id);

      if (response.success && response.data != null) {
        final updatedOrder = PickupOrder.fromJson(response.data!);
        order.value = updatedOrder;
      } else {
        errorMessage.value = response.error ?? 'Error al obtener el estado';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
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

  // Marcar como recogido
  Future<void> markAsPickedUp() async {
    await updateOrderStatus('recogido');
  }
}