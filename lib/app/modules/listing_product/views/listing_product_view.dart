import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/listing_product_controller.dart';
import '../../../common/common_widgets.dart';
import '../../../common/progress_bar.dart';

class ListingProductView extends GetView<ListingProductController> {
  const ListingProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neurogine Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        // Search Bar embedded in the AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search for products (e.g. phone)...',
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF003366)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      // Obx listens to reactive variables from the controller
      body: Obx(() {
        // 1. Initial Loading State
        if (controller.isLoading.value) {
          return const Center(child: AestheticProgressBar());
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

        // 3. Empty State (e.g., Search returned no results)
        if (controller.products.isEmpty) {
          return const Center(
            child: Text(
              'No products found.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        // 4. Success State with Pull-to-Refresh, Grid, & Pagination
        return RefreshIndicator(
          onRefresh: controller.fetchProducts,
          color: const Color(0xFF003366),
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even if list is short
            slivers: [
              // The Product Grid
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 16, // Space between columns
                    mainAxisSpacing: 16, // Space between rows
                    childAspectRatio: 0.72, // Adjusts the height of the cards
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = controller.products[index];
                      return GlassProductCard(
                        title: product.title,
                        imageUrl: product.thumbnail,
                        price: product.price,
                        rating: product.rating,
                        onTap: () {
                          // Navigate to the detail screen and pass the product
                          Get.toNamed('/detail', arguments: product);
                        },
                      );
                    },
                    childCount: controller.products.length,
                  ),
                ),
              ),

              // The Pagination Spinner at the very bottom
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.isLoadingMore.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: AestheticProgressBar()),
                    );
                  }
                  if (!controller.hasMoreData.value && controller.products.isNotEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'You have reached the end!',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox(height: 24); // Padding at the bottom if not loading
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}