import 'package:flutter/material.dart';
import '../constants/colors.dart';

class RoomCard extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final String type;
  final String price;
  final List<String> features;
  final String availability;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.type,
    required this.price,
    required this.features,
    required this.availability,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images avec swipe
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type + "à partir de"
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          type,
                          style: const TextStyle(fontSize: 12, color: AppColors.black),
                        ),
                      ),
                      Text(
                        'à partir de',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary[900],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Titre + Prix alignés
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre à gauche
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Prix + /mois en colonne à droite
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary[900],
                            ),
                          ),
                          Text(
                            '/ mois',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Features
                  Text(
                    features.join(' - '),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 8),

                  // Disponibilité
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 10, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        availability,
                        style: const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
