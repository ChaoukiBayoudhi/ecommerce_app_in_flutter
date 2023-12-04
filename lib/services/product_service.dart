//The service class for the Product Model
//based on the databaseHelper class written using SQLITE
import 'package:ecommerce_app/database/database_helper.dart';
import 'package:ecommerce_app/models/product.dart';

class ProductService{
  final _databaseHelper=DatabaseHelper.instance;

  //create a product
  Future<int> createProduct(Product product) async{
    try{
      final id=await _databaseHelper.insertProduct(product);
      return id;
    }catch(e){
      rethrow;
    }
  }
  //read a product
  Future<Product> readProduct(int id) async{
    try{
      final product=await _databaseHelper.getProduct(id);
      return product;
    }catch(e){
      rethrow;
    }
  }

  //read all products
  Future<List<Map<String, dynamic>>> readAllProducts() async{
    try{
      final products=await _databaseHelper.getAllProducts();
      return products;
    }catch(e){
      rethrow;
    }
  }

  //update a product
  Future<int> updateProduct(Product product) async{
    try{
      final id=await _databaseHelper.updateProduct(product);
      return id;
    }catch(e){
      rethrow;
    }
  }

  //delete a product
  Future<int> deleteProduct(int id) async{
    try{
      final product=await _databaseHelper.deleteProduct(id);
      return product;
    }catch(e){
      rethrow;
    }
  }

  //delete all products
  Future<int> deleteAllProducts() async{
    try{
      final products=await _databaseHelper.deleteAllProducts();
      return products;
    }catch(e){
      rethrow;
    }
  }

  //get outdate products
  Future<List<Map<String, dynamic>>> getOutdatedProducts() async{
    try{
      final products=await _databaseHelper.getOutdatedProducts();
      return products;
    }catch(e){
      rethrow;
    }
  }
  
}