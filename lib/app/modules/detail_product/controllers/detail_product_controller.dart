import 'package:get/get.dart';
import '../../../data/api/api_models/product_model.dart';
import '../../../common/alert_dialog_view.dart'; // Import the new alert

class DetailProductController extends GetxController {
  late ProductModel product;
  
  // Reactive favorite state
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    
    if (isFavorite.value) {
      GlassAlert.show(
        title: 'Added to Favorites',
        message: '${product.title} has been saved to your list.',
      );
    } else {
      GlassAlert.show(
        title: 'Removed from Favorites',
        message: '${product.title} has been removed.',
      );
    }
  }
}