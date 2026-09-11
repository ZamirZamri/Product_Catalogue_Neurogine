import 'package:get/get.dart';
import '../../../data/api/api_models/product_model.dart';

class DetailProductController extends GetxController {
  // This will hold the product passed from the list screen
  late ProductModel product;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the product from GetX routing arguments
    product = Get.arguments as ProductModel;
  }
}