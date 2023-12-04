import 'package:ecommerce_app/screens/products/add_product_screen.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductService>(create: (_) => ProductService()),
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          // Add the route for the AddProductScreen
          AddProductScreen.routeName: (context) => AddProductScreen(),
        },
      ),
    );
  }
}
