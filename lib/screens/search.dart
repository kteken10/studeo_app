import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/room_card.dart';
import 'package:studapart_mobile/ui/custom_app_bar.dart';
import 'package:studapart_mobile/ui/search_card.dart';

import 'package:studapart_mobile/data/rooms_data.dart'; 
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(isDossierComplet: true),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchCard(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: roomsData.length,
                itemBuilder: (context, index) {
                  final room = roomsData[index];
                  return RoomCard(
                    imageUrls: List<String>.from(room['images']),
                    title: room['title'],
                    type: room['type'],
                    price: room['price'],
                    features: List<String>.from(room['features']),
                    availability: room['availability'],
                    onTap: () {
                      // Ici tu peux naviguer vers une page de détails
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
