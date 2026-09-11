import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      // We will define our Dark Blue & White theme in common_widgets later
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Very light gray/blue background
        primaryColor: const Color(0xFF003366), // Dark Blue
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Architecture Setup Complete!'),
        ),
      ),
    );
  }
}