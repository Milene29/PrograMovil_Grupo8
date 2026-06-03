import 'package:get/get.dart';
import '../../models/product.dart';

class ProductDetailController extends GetxController {
  late final Product product;

  final RxString selectedSize = ''.obs;
  final RxString selectedSugar = ''.obs;
  final RxList<String> selectedExtras = <String>[].obs;
  final RxInt quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;

    if (product.category.id == 1) {
      selectedSize.value = 'Mediano (12oz)';
      selectedSugar.value = 'Sin azúcar';
    } else if (product.category.id == 2) {
      selectedSize.value = 'Mediano (12oz)';
      selectedSugar.value = 'Hielo regular';
    } else {
      selectedSize.value = 'Porción Regular';
      selectedSugar.value = 'Frío / Normal';
    }
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectSugar(String sugar) {
    selectedSugar.value = sugar;
  }

  void toggleExtra(String extraName) {
    if (selectedExtras.contains(extraName)) {
      selectedExtras.remove(extraName);
    } else {
      selectedExtras.add(extraName);
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  List<Map<String, dynamic>> get availableExtras {
    if (product.category.id == 1) {
      return [
        {'name': 'Shot extra de espresso', 'price': 2.00},
        {'name': 'Leche de almendras', 'price': 1.50},
        {'name': 'Jarabe de vainilla', 'price': 1.00},
      ];
    } else if (product.category.id == 2) {
      return [
        {'name': 'Crema batida', 'price': 1.50},
        {'name': 'Jarabe de vainilla', 'price': 1.00},
        {'name': 'Salsa de caramelo', 'price': 1.50},
      ];
    } else {
      return [
        {'name': 'Porción extra de mantequilla', 'price': 1.00},
        {'name': 'Mermelada', 'price': 1.00},
      ];
    }
  }

  List<String> get availableSizes {
    if (product.category.id == 1) {
      return ['Pequeño (8oz)', 'Mediano (12oz)', 'Grande (16oz)'];
    } else if (product.category.id == 2) {
      return ['Mediano (12oz)', 'Grande (16oz)'];
    } else {
      return ['Porción Regular'];
    }
  }

  List<String> get availableSugarOptions {
    if (product.category.id == 1) {
      return ['Sin azúcar', '1 sobre', '2 sobres', '3 sobres'];
    } else if (product.category.id == 2) {
      return ['Hielo regular', 'Poco hielo', 'Sin hielo'];
    } else {
      return ['Caliente / Tostado', 'Frío / Normal'];
    }
  }

  double get unitPrice {
    double price = product.price;

    if (selectedSize.value == 'Pequeño (8oz)') {
      price -= 1.00;
    } else if (selectedSize.value == 'Grande (16oz)') {
      price += 2.00;
    }

    for (var extra in availableExtras) {
      if (selectedExtras.contains(extra['name'])) {
        price += extra['price'] as double;
      }
    }

    return price;
  }

  double get totalPrice {
    return unitPrice * quantity.value;
  }
}
