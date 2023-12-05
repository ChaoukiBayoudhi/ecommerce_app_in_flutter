import 'package:ecommerce_app/screens/products/add_product_screen.dart';
import 'package:ecommerce_app/screens/products/list_products_sceen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      initialRoute: '/',
      routes: {
        '/': (context) => ProductsListScreen(),
        '/add-product': (context) => AddProductScreen(),
      },
    );
  }
}
