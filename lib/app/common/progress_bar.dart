import 'package:flutter/material.dart';

class AestheticProgressBar extends StatelessWidget {
  const AestheticProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 40, // Slightly increased size to fit the thicker stroke
        width: 40,
        child: CircularProgressIndicator(
          strokeWidth: 6.0, // Made thicker!
          strokeCap: StrokeCap.round, // This makes the edges perfectly rounded
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF003366)), 
          backgroundColor: Colors.transparent, 
        ),
      ),
    );
  }
}