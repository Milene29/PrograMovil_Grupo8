import 'package:get/get.dart';
import '../../configs/generic_response.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

class MenuController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<Category> categories = <Category>[].obs;
  final RxList<Product> recommendedProducts = <Product>[].obs;
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> displayedProducts = <Product>[].obs;

  final RxInt selectedCategoryId = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    try {
      GenericResponse<List<Category>> catResponse = await _productService
          .fetchCategories();
      if (catResponse.success && catResponse.data != null) {
        categories.value = catResponse.data!;
      }

      GenericResponse<List<Product>> recResponse = await _productService
          .fetchRecommended();
      if (recResponse.success && recResponse.data != null) {
        recommendedProducts.value = recResponse.data!;
      }

      GenericResponse<List<Product>> allResponse = await _productService
          .fetchAllProducts();
      if (allResponse.success && allResponse.data != null) {
        allProducts.value = allResponse.data!;
      }

      filterProducts();
    } catch (e) {
      Get.log('Error al cargar datos en MenuController: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
    filterProducts();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void filterProducts() {
    List<Product> temp = allProducts;

    if (selectedCategoryId.value != 0) {
      temp = temp
          .where((p) => p.category.id == selectedCategoryId.value)
          .toList();
    }

    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      temp = temp
          .where(
            (p) =>
                p.name.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query),
          )
          .toList();
    }

    displayedProducts.value = temp;
  }
}
