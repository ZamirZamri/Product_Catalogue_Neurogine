import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlassAlert {
  static void show({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
      // Glassmorphism effect properties
      backgroundColor: Colors.white.withOpacity(0.3),
      barBlur: 15,
      overlayBlur: 0,
      borderColor: Colors.white.withOpacity(0.5),
      borderWidth: 1.2,
      borderRadius: 20,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 5),
        )
      ],
      // Typography
      colorText: Colors.black,
      titleText: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      messageText: Text(
        message,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
      icon: const Icon(Icons.check_circle_outline, color: Color(0xFF003366)),
      // Smooth animation from the AppBar
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}