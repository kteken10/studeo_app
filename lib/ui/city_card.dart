import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';

class CityCard extends StatelessWidget {
  final String image; // chemin de l'image locale
  final String title;
  final VoidCallback onTap;

  const CityCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  static const double cardMargin = 16;
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - cardMargin * 3) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
      
        margin: const EdgeInsets.symmetric( vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // coins arrondis appliqués à tout
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image de fond
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              // Overlay pour le titre
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary[900], // bg-primary-900/90
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // text-base
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
