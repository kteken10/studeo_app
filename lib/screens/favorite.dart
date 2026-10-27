import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/data/rooms_data.dart';
import 'package:studapart_mobile/ui/custom_app_bar.dart';
import 'package:studapart_mobile/ui/room_card.dart';

/// Logements sauvegardés : ceux marqués `isFavorite` dans les données.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = roomsData.where((room) => room['isFavorite'] == true).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(isDossierComplet: true),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            'Mes favoris',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${favorites.length} logements sauvegardés',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          for (final room in favorites)
            RoomCard(
              imageUrls: List<String>.from(room['images']),
              title: room['title'],
              type: room['type'],
              price: room['price'],
              originalPrice: room['originalPrice'],
              currentPrice: room['currentPrice'],
              features: List<String>.from(room['features']),
              availability: room['availability'],
              isFavorite: true,
              isOnPromotion: room['isOnPromotion'] ?? false,
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
