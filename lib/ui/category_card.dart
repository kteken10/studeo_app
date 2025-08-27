import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; 

class CategoryCard extends StatelessWidget {
  final String name;
  final double? width;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.name,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80, 
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 4), 
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Ionicons.fast_food_outline,
              size: 24,
              color: Color(0xFFFF8800), 
            ),
            const SizedBox(height: 4), 
            Text(
              name,
              style: TextStyle(
                color: Colors.grey.shade600, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
