import 'package:get/get.dart';
import '../modules/listing_product/bindings/listing_product_binding.dart';
import '../modules/listing_product/views/listing_product_view.dart';
import '../modules/detail_product/bindings/detail_product_binding.dart';
import '../modules/detail_product/views/detail_product_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.LISTING,
      page: () => const ListingProductView(),
      binding: ListingProductBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailProductView(),
      binding: DetailProductBinding(),
    ),
  ];
}