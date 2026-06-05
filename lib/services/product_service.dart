import '../configs/generic_response.dart';
import '../models/category.dart';
import '../models/product.dart';

class ProductService {
  final List<Category> _mockCategories = [
    Category(id: 1, name: 'Bebidas Calientes'),
    Category(id: 2, name: 'Bebidas Frías'),
    Category(id: 3, name: 'Snacks & Postres'),
  ];

  late final List<Product> _mockProducts;

  ProductService() {
    _mockProducts = [
      Product(
        id: 1,
        name: 'Café Americano',
        description: 'Café negro de filtro preparado con granos selectos de altura.',
        price: 5.50,
        image: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500&auto=format&fit=crop',
        prepTime: '3 min',
        category: _mockCategories[0],
        isRecommended: false,
      ),
      Product(
        id: 2,
        name: 'Cappuccino',
        description: 'Espresso con espuma de leche perfecta y toque de canela.',
        price: 7.00,
        image: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500&auto=format&fit=crop',
        prepTime: '3 min',
        category: _mockCategories[0],
        isRecommended: true,
      ),
      Product(
        id: 3,
        name: 'Latte',
        description: 'Espresso suave con leche vaporizada.',
        price: 7.50,
        image: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500&auto=format&fit=crop',
        prepTime: '3 min',
        category: _mockCategories[0],
        isRecommended: true,
      ),
      Product(
        id: 4,
        name: 'Croissant',
        description: 'Clásico pan francés crujiente y hojaldrado, horneado diariamente.',
        price: 6.00,
        image: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&auto=format&fit=crop',
        prepTime: '2 min',
        category: _mockCategories[2],
        isRecommended: true,
      ),
      Product(
        id: 5,
        name: 'Mocaccino',
        description: 'Café con leche y caramelo dulce, coronado con crema batida.',
        price: 7.50,
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYVmS6txB28CIcIYcNVKvaoQXIoqa_s8g-QNguvg4ImttEmxWnX2WEA6ckFmRWMLFzuoNI9TYVaKB8r7r32TIt5YLNE7omq9EBqIdrNM8&s=10',
        prepTime: '4 min',
        category: _mockCategories[0],
        isRecommended: false,
      ),
      Product(
        id: 6,
        name: 'Iced Latte',
        description: 'Espresso frío con leche vaporizada fresca y cubos de hielo.',
        price: 8.50,
        image: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&auto=format&fit=crop',
        prepTime: '4 min',
        category: _mockCategories[1],
        isRecommended: false,
      ),
      Product(
        id: 7,
        name: 'Frappuccino',
        description: 'Café licuado con hielo, leche y decorado con crema batida.',
        price: 9.50,
        image: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500&auto=format&fit=crop',
        prepTime: '5 min',
        category: _mockCategories[1],
        isRecommended: true,
      ),
      Product(
        id: 8,
        name: 'Muffin de Chocolate',
        description: 'Muffin suave relleno de chispas de chocolate belga.',
        price: 6.50,
        image: 'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=500&auto=format&fit=crop',
        prepTime: '1 min',
        category: _mockCategories[2],
        isRecommended: false,
      ),
    ];
  }

  Future<GenericResponse<List<Category>>> fetchCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return GenericResponse(
      success: true,
      data: _mockCategories,
      message: 'Categorías obtenidas con éxito',
    );
  }

  Future<GenericResponse<List<Product>>> fetchAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return GenericResponse(
      success: true,
      data: _mockProducts,
      message: 'Productos obtenidos con éxito',
    );
  }

  Future<GenericResponse<List<Product>>> fetchRecommended() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final recommended = _mockProducts.where((p) => p.isRecommended).toList();
    return GenericResponse(
      success: true,
      data: recommended,
      message: 'Recomendados obtenidos con éxito',
    );
  }

  Future<GenericResponse<List<Product>>> fetchByCategory(int categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final filtered = _mockProducts.where((p) => p.category.id == categoryId).toList();
    return GenericResponse(
      success: true,
      data: filtered,
      message: 'Productos filtrados obtenidos con éxito',
    );
  }
}
