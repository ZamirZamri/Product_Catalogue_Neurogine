import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/api/api_methods.dart';
import '../../../data/api/api_models/product_model.dart';
import '../../../data/api/api_models/product_response_model.dart';

class ListingProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var hasMoreData = true.obs;
  
  // NEW: Search Query State
  var searchQuery = ''.obs;

  int skip = 0;
  final int limit = 20;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _addScrollListener();

    // GetX Built-in Debounce! 
    // It waits 500ms after the user stops typing before running fetchProducts()
    debounce(searchQuery, (_) {
      fetchProducts();
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      hasError(false);
      skip = 0;
      hasMoreData(true);
      
      ProductResponseModel response;
      
      //Check if we are searching or just listing
      if (searchQuery.value.trim().isEmpty) {
        response = await ApiMethods.getProducts(limit: limit, skip: skip);
      } else {
        response = await ApiMethods.searchProducts(searchQuery.value.trim(), limit: limit, skip: skip);
      }
      
      products.assignAll(response.products);
      skip += limit;
      
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

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore(true);
      
      ProductResponseModel response;
      
      // NEW: Pagination works for both normal lists and search results!
      if (searchQuery.value.trim().isEmpty) {
        response = await ApiMethods.getProducts(limit: limit, skip: skip);
      } else {
        response = await ApiMethods.searchProducts(searchQuery.value.trim(), limit: limit, skip: skip);
      }
      
      if (response.products.isEmpty) {
        hasMoreData(false);
      } else {
        products.addAll(response.products);
        skip += limit;
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Could not load more products. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingMore(false);
    }
  }

  void _addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        loadMoreProducts();
      }
    });
  }
}