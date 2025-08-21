import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; // package:ionicons

class CategoryCard extends StatelessWidget {
  final String name;
  final double? width;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.name,
    this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80, // équiv. h-20
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 4), // mx-1
        decoration: BoxDecoration(
          color: Colors.grey.shade200, // bg-neutral-200
          borderRadius: BorderRadius.circular(16), // rounded-xl
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Ionicons.fast_food_outline,
              size: 24,
              color: Color(0xFFFF8800), // orange
            ),
            const SizedBox(height: 4), // équiv. gap-2
            Text(
              name,
              style: TextStyle(
                color: Colors.grey.shade600, // text-neutral-600
              ),
            ),
          ],
        ),
      ),
    );
  }
}
