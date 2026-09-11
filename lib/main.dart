import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/common/theme_data.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

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
      // Use GetX Routing
      initialRoute: Routes.LISTING,
      getPages: AppPages.routes,
    );
  }
}