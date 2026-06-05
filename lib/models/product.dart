import 'category.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String prepTime;
  final Category category;
  final bool isRecommended;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.prepTime,
    required this.category,
    required this.isRecommended,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      prepTime: json['prep_time'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      isRecommended: json['is_recommended'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'prep_time': prepTime,
      'category': category.toJson(),
      'is_recommended': isRecommended,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, category: ${category.name})';
  }
}
