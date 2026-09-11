import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/listing_product_controller.dart';
import '../../../common/common_widgets.dart';

class ListingProductView extends GetView<ListingProductController> {
  const ListingProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neurogine Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      // Obx listens to reactive variables from the controller
      body: Obx(() {
        // 1. Loading State
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Error State with Retry Button
        if (controller.hasError.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: controller.fetchProducts,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        // 3. Empty State
        if (controller.products.isEmpty) {
          return const Center(
            child: Text('No products found.', style: TextStyle(fontSize: 18, color: Colors.black54)),
          );
        }

        // 4. Success State with Pull-to-Refresh & Pagination
        return RefreshIndicator(
          onRefresh: controller.fetchProducts,
          color: const Color(0xFF003366),
          child: ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even if list is short
            itemCount: controller.products.length + 1, // +1 for the loading spinner at the bottom
            itemBuilder: (context, index) {
              
              // Handle the very last item (Pagination Spinner)
              if (index == controller.products.length) {
                if (controller.isLoadingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (!controller.hasMoreData.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text('You have reached the end!', style: TextStyle(color: Colors.black54))),
                  );
                }
                return const SizedBox.shrink();
              }

              // Handle Product Cards
              final product = controller.products[index];
              return GlassProductCard(
                title: product.title,
                imageUrl: product.thumbnail,
                price: product.price,
                onTap: () {
                  // We will implement the routing in Commit 6
                  Get.snackbar('Coming Soon', 'Detail page for ${product.title}');
                },
              );
            },
          ),
        );
      }),
    );
  }
}