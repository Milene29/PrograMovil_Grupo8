import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';

// ─────────────────────────────────────────────
// MODELO: item dentro del carrito
// ─────────────────────────────────────────────
class CartEntry {
  final Product product;
  final String selectedSize;
  final String selectedSugar;
  final List<String> selectedExtras;
  final double unitPrice;
  final RxInt quantity;

  CartEntry({
    required this.product,
    required this.selectedSize,
    required this.selectedSugar,
    required this.selectedExtras,
    required this.unitPrice,
    int initialQuantity = 1,
  }) : quantity = initialQuantity.obs;

  double get total => unitPrice * quantity.value;

  String get extrasLabel =>
      selectedExtras.isEmpty ? 'Sin extras' : selectedExtras.join(', ');
}

// ─────────────────────────────────────────────
// CONTROLLER
// ─────────────────────────────────────────────
class CartController extends GetxController {
  final RxList<CartEntry> entries = <CartEntry>[].obs;

  // ── Totales ──────────────────────────────────
  double get subtotal => entries.fold(0, (sum, e) => sum + e.total);

  int get totalItems => entries.fold(0, (sum, e) => sum + e.quantity.value);

  // ── Agregar producto ─────────────────────────
  /// Llamado desde ProductDetailPage al presionar "Agregar"
  void addFromDetail({
    required Product product,
    required String selectedSize,
    required String selectedSugar,
    required List<String> selectedExtras,
    required double unitPrice,
    required int quantity,
  }) {
    // Si ya existe la misma combinación, solo sube la cantidad
    final existing = entries.firstWhereOrNull(
      (e) =>
          e.product.id == product.id &&
          e.selectedSize == selectedSize &&
          e.selectedSugar == selectedSugar,
    );

    if (existing != null) {
      existing.quantity.value += quantity;
    } else {
      entries.add(CartEntry(
        product: product,
        selectedSize: selectedSize,
        selectedSugar: selectedSugar,
        selectedExtras: List.from(selectedExtras),
        unitPrice: unitPrice,
        initialQuantity: quantity,
      ));
    }

    Get.snackbar(
      'Carrito',
      '${product.name} agregado al carrito',
      backgroundColor: const Color(0xFF7A0C2E),
      colorText: const Color(0xFFFFFFFF),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // ── Modificar cantidad ───────────────────────
  void increment(int index) {
    entries[index].quantity.value++;
    entries.refresh();
  }

  void decrement(int index) {
    if (entries[index].quantity.value > 1) {
      entries[index].quantity.value--;
    } else {
      entries.removeAt(index);
    }
    entries.refresh();
  }

  void removeEntry(int index) {
    entries.removeAt(index);
  }

  void clearCart() => entries.clear();
}
