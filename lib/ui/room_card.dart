import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/pulsing_circl.dart';
import '../constants/colors.dart';

class RoomCard extends StatefulWidget {
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
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = widget.availability.toLowerCase().contains('disponible') &&
        !widget.availability.toLowerCase().contains('à partir');
    final Color availabilityColor = isAvailable ? Colors.green : Colors.red;

    // Prix affiché selon si promo ou non
    final String displayedPrice = widget.isOnPromotion
        ? (widget.currentPrice ?? widget.price ?? "Prix indisponible")
        : (widget.price ?? "Prix indisponible");

    return GestureDetector(
      onTap: widget.onTap,
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
            // Images avec swipe, favoris et promotion badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: widget.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          widget.imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
                // Badge promotion centré horizontalement
                if (widget.isOnPromotion)
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                    ),
                  ),
                // Bouton favoris en haut à droite
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey.shade400,
                        size: 18,
                      ),
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
                          widget.type,
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
                  // Titre + Prix
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!widget.isOnPromotion) const SizedBox(height: 0),
                          if (widget.isOnPromotion && widget.originalPrice != null) ...[
                            Text(
                              widget.originalPrice!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.ternary[900],
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
                              color: widget.isOnPromotion ? Colors.blue : AppColors.primary[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Features
                  Text(
                    widget.features.join(' - '),
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
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  PulsatingCircle(color: availabilityColor),
                  const SizedBox(width: 6),
                  Text(
                    widget.availability,
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
