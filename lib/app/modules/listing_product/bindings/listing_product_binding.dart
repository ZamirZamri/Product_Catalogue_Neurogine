import 'package:get/get.dart';
import '../controllers/listing_product_controller.dart';

class ListingProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingProductController>(() => ListingProductController());
  }
}