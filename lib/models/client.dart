
import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/models/command.dart';

class Client{
  int id;
  String name;
  String email;
  String phone;
  Address address;
  String? website;
  String? industry;
  String? logo;
  String? description;
  List<Command>? commands=[];

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.website,
    this.industry,
    this.logo,
    this.description,
    this.commands,
  });

  factory Client.fromJson(Map<String, dynamic> json){
    return Client(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: Address.fromJson(json['address']),
      website: json['website'],
      industry: json['industry'],
      logo: json['logo'],
      description: json['description'],
      commands: json['commands'].map<Command>((json) => Command.fromJson(json)).toList(),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'website': website,
      'industry': industry,
      'logo': logo,
      'description': description,
      'commands': commands,
    };
  }
}