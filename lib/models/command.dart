import 'package:ecommerce_app/models/client.dart';
import 'package:ecommerce_app/models/product.dart';

class Command{
  int id;
  String name;
  String description;
  double amount;
  Product product;
  Client client;
  final DateTime commandedAt;

  Command({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.product,
    required this.client,
  }) : commandedAt = DateTime.now();


//used to convert from Json format to Dart object (Command object)
//{'name':'command1', 'description':'description1', 'amount': 100, 'product': 'product1', 'client': 'client1'}
//factory is used to return a new instance of the Command class
//Factory is used because we'll use asynchronous method to get data from the server
//and we need to wait for the data to be fetched before returning the new instance

  factory Command.fromJson(Map<String, dynamic> json){
    return Command(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      amount: json['amount'],
      product: Product.fromJson(json['product']),
      client: Client.fromJson(json['client']),
    );
  }

//used to convert from Dart object (Command object) to Json format
//{'name':'command1', 'description':'description1', 'amount': 100, 'product': 'product1', 'client': 'client1'}
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'product': product,
      'client': client,
    };
  }
}