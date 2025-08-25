import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/pulsing_circl.dart';
import '../constants/colors.dart';

class RoomCard extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final String type;
  final String? price; // prix normal si pas de promo
  final String? originalPrice; // prix barré si promo
  final String? currentPrice; // prix actuel si promo
  final List<String> features;
  final String availability;
  final bool isFavorite;
  final bool isOnPromotion;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.type,
    this.price,
    this.originalPrice,
    this.currentPrice,
    required this.features,
    required this.availability,
    this.isFavorite = false,
    this.isOnPromotion = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = availability.toLowerCase().contains('disponible') &&
        !availability.toLowerCase().contains('à partir');
    final Color availabilityColor = isAvailable ? Colors.green : Colors.red;

    // Prix affiché selon si promo ou non
    final String displayedPrice = isOnPromotion
        ? (currentPrice ?? "Prix indisponible")
        : (price ?? "Prix indisponible");

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images avec swipe et bouton favoris
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
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
               Positioned(
  top: 8,
  right: 8,
  child: Container(
    padding: const EdgeInsets.all(6), // espace autour de l'icône
    decoration: BoxDecoration(
      color: Colors.white, // fond blanc
      shape: BoxShape.circle, // forme circulaire
      
    ),
    child: Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.grey.shade400,
      size: 18
    ),
  ),
),

              ],
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
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                          ),
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

                  // Titre + Prix + Promotion
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
                          // Badge promo
                          if (isOnPromotion)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                'Promotion en cours',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          // Prix barré si promo
                          if (isOnPromotion && originalPrice != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              originalPrice!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],

                          const SizedBox(height: 4),

                          // Prix affiché
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary[900],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              displayedPrice,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '/ mois',
                            style: TextStyle(
                              fontSize: 12,
                              color: isOnPromotion
                                  ? Colors.blue
                                  : AppColors.primary[900],
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
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary[800],
                    ),
                  ),
                ],
              ),
            ),

            // Disponibilité avec effet pulsation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.primary[100]!.withOpacity(0.3),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  PulsatingCircle(color: availabilityColor),
                  const SizedBox(width: 6),
                  Text(
                    availability,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
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
