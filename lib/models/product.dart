import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/command.dart';

class Product{
   int? id;
   String name;
   String description;
   double price;
   String? image;
   int stock;
   DateTime? factoryDate;
   DateTime expirationDate;
   List<Command>? commands;
   Category? category;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.stock,
    this.factoryDate,
    required this.expirationDate,
    this.commands,
    this.category,
  });

  //surcharge constructor
  Product.withId({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.stock,
    this.factoryDate,
    required this.expirationDate,
    this.commands,
    this.category,
  });




//used to convert from Json format to Dart object (Product object)
//{'name':'product1', 'description':'description1', 'price': 100, 'image':'image1', 'stock': 10}
//factory is used to return a new instance of the Product class
//Factory is used because we'll use asynchronous method to get data from the server
//and we need to wait for the data to be fetched before returning the new instance

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      stock: json['stock'],
      factoryDate: json['factoryDate'],
      expirationDate: json['expirationDate'],
      commands: json['commands'].map<Command>((json) => Command.fromJson(json)).toList(),
      category: Category.fromJson(json['category']),
    );
  }

//used to convert from Dart object (Product object) to Json format
//{'name':'product1', 'description':'description1', 'price': 100, 'image':'image1', 'stock': 10}
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'stock': stock,
      'factoryDate': factoryDate,
      'expirationDate': expirationDate,
      'commands': commands,
      'category': category,
    };
  }

}