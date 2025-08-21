import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/custom_app_bar.dart';
import 'package:studapart_mobile/ui/search_card.dart'; // ⬅️ importe ton composant

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // hauteur de ton appbar
        child: CustomAppBar(
          isDossierComplet: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8), // un peu d’espace autour
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchCard(), // 🔍 ton champ de recherche
            const SizedBox(height: 20), // espace entre la barre de recherche et le contenu
          
          ],
        ),
      ),
    );
  }
}
