import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/pulsing_circl.dart';
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
    // Détermination de la couleur de disponibilité
    final bool isAvailable = availability.toLowerCase().contains('disponible') && !availability.toLowerCase().contains('à partir');
    final Color availabilityColor = isAvailable ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.grey.shade300, // bordure de la carte
            width: 1,
          ),
        ),
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
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         Container(
  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  decoration: BoxDecoration(
    color: AppColors.primary[900],
    borderRadius: BorderRadius.circular(50)
  ),
  child: Text(
    price,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.white
    ),
  ),
)
,
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
                    style: TextStyle(fontSize: 12, color: AppColors.primary[800]
                  ),
                  ),
                ],
              ),
            ),

            // Disponibilité avec container noir
            // Disponibilité avec effet pulsation
Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  decoration: BoxDecoration(
    color: AppColors.primary[100]!.withOpacity(0.3),
    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
  ),
  child: Row(
    children: [
      // Pulsating circle
      PulsatingCircle(color: availabilityColor),
      const SizedBox(width: 6),
      Text(
        availability,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black
        ),
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
