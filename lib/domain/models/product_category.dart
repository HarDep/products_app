import 'dart:convert';

class ProductCategory {
  final String name;
  final String image;

  ProductCategory({
    required this.name,
    required this.image,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'image' : image,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      name: map['name'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) => ProductCategory.fromMap(json.decode(source));
}
