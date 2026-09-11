import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/api/api_methods.dart';
import '../../../data/api/api_models/product_model.dart';

class ListingProductController extends GetxController {
  // 1. Reactive State Variables
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;           // For the initial load
  var isLoadingMore = false.obs;      // For pagination loading at the bottom
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var hasMoreData = true.obs;         // To stop fetching when we reach the end

  // 2. Pagination Trackers
  int skip = 0;
  final int limit = 20;

  // Scroll Controller to detect when user reaches the bottom
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _addScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Initial Fetch & Retry Mechanism
  Future<void> fetchProducts() async {
    try {
      // Reset states
      isLoading(true);
      hasError(false);
      skip = 0;
      hasMoreData(true);
      
      final response = await ApiMethods.getProducts(limit: limit, skip: skip);
      
      products.assignAll(response.products); // Overwrite list
      
      // Update skip for the next pagination call
      skip += limit;
      
      // Check if already got all items
      if (response.products.length < limit) {
        hasMoreData(false);
      }
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Pagination Fetch
  Future<void> loadMoreProducts() async {
    // Prevent multiple simultaneous calls or calling when no more data exists
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore(true);
      
      final response = await ApiMethods.getProducts(limit: limit, skip: skip);
      
      if (response.products.isEmpty) {
        hasMoreData(false);
      } else {
        products.addAll(response.products); // Append to list
        skip += limit;
      }
    } catch (e) {
      // For pagination, i just print the error and show a quick snackbar
      // rather than replacing the whole screen with an error state.
      Get.snackbar(
        'Error', 
        'Could not load more products. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingMore(false);
    }
  }

  // Listens to scrolling and triggers loadMoreProducts when near the bottom
  void _addScrollListener() {
    scrollController.addListener(() {
      // Load more when user scrolls to within 200 pixels of the bottom
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        loadMoreProducts();
      }
    });
  }
}