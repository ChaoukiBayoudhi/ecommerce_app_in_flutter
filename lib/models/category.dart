import 'package:ecommerce_app/models/product.dart';

class Category{
  int id;
  String name;
  String? image;
  String description;
  List<Product>? products;

  Category(this.id,this.products,  this.name, this.image, this.description);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    json['id'],
    json['products']?.map<Product>((json) => Product.fromJson(json)).toList(),
    json['name'],
    json['image'],
    json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
    'products': products?.map((products) => products.toJson()).toList(),
  };
}