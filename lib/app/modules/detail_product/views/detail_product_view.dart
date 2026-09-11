import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Icon(
                controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(controller.isFavorite.value), // Crucial for animation
                color: controller.isFavorite.value ? Colors.redAccent : Colors.white,
              ),
            ),
            onPressed: controller.toggleFavorite,
          )),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Swipeable Image Gallery
            SizedBox(
              height: 320,
              width: double.infinity,
              child: PageView.builder(
                itemCount: product.images.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: product.images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 60, color: Color(0xFF003366)),
                  );
                },
              ),
            ),
            
            // 2. Product Details Container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF003366)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating} / 5.0',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 40), // Bottom padding for scrolling
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}