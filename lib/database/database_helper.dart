//database helper class using SQLite
//models are Product, Client, Command and Category
//we'll use the same database for all models
//a product can be commanded by many clients
//a client can command many products
//a product can be in one categories
//a category can have many products
//the database is named e_commerce.db
import 'dart:async';
import 'dart:io';

import 'package:ecommerce_app/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //create a private constructor
  DatabaseHelper._();
  //create a static instance of the class
  static final DatabaseHelper instance = DatabaseHelper._();
  //define the database name
  static const _dbName = 'e_commerce.db';
  //define the database version
  static const _dbVersion = 1;
  //define the table names
  static const _productTable = 'products';
  static const _clientTable = 'clients';
  static const _commandTable = 'commands';
  static const _categoryTable = 'categories';
  //define the column names for the product table
  static const _columnProductId = 'id';
  static const _columnProductName = 'name';
  static const _columnProductDescription = 'description';
  static const _columnProductPrice = 'price';
  static const _columnProductImage = 'image';
  static const _columnProductStock = 'stock';
  static const _columnProductFactoryDate = 'factoryDate';
  static const _columnProductExpirationDate = 'expirationDate';
  static const _columnProductCategoryId = 'categoryId';
  //define the column names for the client table
  static const _columnClientId = 'id';
  static const _columnClientName = 'name';
  static const _columnClientEmail = 'email';
  static const _columnClientPhone = 'phone';
  static const _columnClientAddress = 'address';
  static const _columnClientWebsite = 'website';
  static const _columnClientIndustry = 'industry';
  static const _columnClientLogo = 'logo';
  static const _columnClientDescription = 'description';
  //define the column names for the command table
  static const _columnCommandId = 'id';
  static const _columnCommandName = 'name';
  static const _columnCommandDescription = 'description';
  static const _columnCommandAmount = 'amount';
  static const _columnCommandProductId = 'productId';
  static const _columnCommandClientId = 'clientId';
  static const _columnCommandCommandedAt = 'commandedAt';
  //define the column names for the category table
  static const _columnCategoryId = 'id';
  static const _columnCategoryName = 'name';
  static const _columnCategoryImage = 'image';
  static const _columnCategoryDescription = 'description';
  //define a database object
  static Database? _database;
  //

  //define a getter for the database
  Future<Database> get database async {
    //if the database is not null, then return it
    if (_database != null) return _database!;
    //if the database is null, then initialize it
    _database = await _initDatabase();
    return _database!;
  }

  //initialize the database
  _initDatabase() async {
    //get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _dbName;
    //open/create the database at a given path
    return await openDatabase(path,
        version: _dbVersion, onCreate: _createDatabase);
  }

  //create the database tables
Future<void> _createDatabase(Database db, int version) async {
  // Create the tables
  await db.execute('''
    CREATE TABLE $_productTable (
      $_columnProductId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnProductName TEXT NOT NULL,
      $_columnProductDescription TEXT,
      $_columnProductPrice REAL NOT NULL,
      $_columnProductImage TEXT,
      $_columnProductStock INTEGER NOT NULL,
      $_columnProductFactoryDate TEXT,
      $_columnProductExpirationDate TEXT,
      $_columnProductCategoryId INTEGER NOT NULL,
      FOREIGN KEY ($_columnProductCategoryId) REFERENCES $_categoryTable($_columnCategoryId)
    )
  ''');

  await db.execute('''
    CREATE TABLE $_clientTable (
      $_columnClientId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnClientName TEXT NOT NULL,
      $_columnClientEmail TEXT NOT NULL UNIQUE,
      $_columnClientPhone TEXT,
      $_columnClientAddress TEXT,
      $_columnClientWebsite TEXT,
      $_columnClientIndustry TEXT,
      $_columnClientLogo TEXT,
      $_columnClientDescription TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE $_commandTable (
      $_columnCommandId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnCommandName TEXT NOT NULL,
      $_columnCommandDescription TEXT,
      $_columnCommandAmount INTEGER NOT NULL,
      $_columnCommandProductId INTEGER NOT NULL,
      $_columnCommandClientId INTEGER NOT NULL,
      $_columnCommandCommandedAt TEXT NOT NULL,
      FOREIGN KEY ($_columnCommandProductId) REFERENCES $_productTable($_columnProductId),
      FOREIGN KEY ($_columnCommandClientId) REFERENCES $_clientTable($_columnClientId)
    )
  ''');

  await db.execute('''
    CREATE TABLE $_categoryTable (
      $_columnCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnCategoryName TEXT NOT NULL,
      $_columnCategoryImage TEXT,
      $_columnCategoryDescription TEXT
    )
  ''');

  return; // explicitly return void to satisfy the callback return type
}

//CRUD operations for the product table
//Create operation: Insert a product object to database
Future<int> insertProduct(Product product) async {
  Database db = await database;
  return await db.insert(_productTable, product.toJson());
}

//Read operation: Get all products from database
Future<List<Map<String, dynamic>>> getAllProducts() async {
  Database db = await database;
  return await db.query(_productTable);
}

//Read operation: Get a product object from database
Future<Product> getProduct(int id) async {
  Database db = await database;
  var res= await db.query(_productTable,
      where: '$_columnProductId = ?', whereArgs: [id]);
  return Product.fromJson(res.first);
}

//Update operation: Update a product object and save it to database

Future<int> updateProduct(Product product) async {
  Database db = await database;
  return await db.update(_productTable, product.toJson(),
      where: '$_columnProductId = ?', whereArgs: [product.id]);
}

//Delete operation: Delete a product object from database

Future<int> deleteProduct(int id) async {
  Database db = await database;
  return await db
      .delete(_productTable, where: '$_columnProductId = ?', whereArgs: [id]);
}

//Delete operation: Delete all products from database

Future<int> deleteAllProducts() async {
  Database db = await database;
  return await db.delete(_productTable);
}

//Get number of product objects in database

Future<int?> getCount() async {
  Database db = await database;
  List<Map<String, dynamic>> x =
      await db.rawQuery('SELECT COUNT (*) from $_productTable');
  int? result = Sqflite.firstIntValue(x);
  return result;
}

//get name, price and stock of outdate products

Future<List<Map<String, dynamic>>> getOutdatedProducts() async {
  Database db = await database;
  return await db.rawQuery(
      'SELECT $_columnProductName, $_columnProductPrice, $_columnProductStock FROM $_productTable WHERE $_columnProductExpirationDate < date(\'now\')');
}

//get products commanded by a given client between two dates

Future<List<Map<String, dynamic>>> getProductsCommandedByClientBetweenTwoDates(
    int clientId, String startDate, String endDate) async {
  Database db = await database;
  return await db.rawQuery(
      'SELECT $_columnProductName, $_columnProductPrice, $_columnProductStock FROM $_productTable WHERE $_columnCommandClientId = $clientId AND $_columnCommandCommandedAt BETWEEN $startDate AND $endDate');
}


//the same thing for other tables

}

