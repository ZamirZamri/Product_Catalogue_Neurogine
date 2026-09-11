import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/common/theme_data.dart';
import 'app/modules/listing_product/bindings/listing_product_binding.dart';
import 'app/modules/listing_product/views/listing_product_view.dart';

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
      theme: AppTheme.lightTheme,
      initialBinding: ListingProductBinding(),
      home: const ListingProductView(),
    );
  }
}