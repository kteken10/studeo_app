import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/data/locations.dart';
import 'package:studapart_mobile/ui/city_card.dart';
import 'package:studapart_mobile/ui/daily_promo_card.dart';


import 'package:studapart_mobile/ui/location_selector.dart';
import 'package:studapart_mobile/ui/rental.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double scrollOffset = 0;
  Country selectedCountry = countries.first; // par défaut France

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void handleCityPress(String city) {
    debugPrint("Ville sélectionnée : $city");
    // Navigator.push(...) si besoin
  }

  @override
  Widget build(BuildContext context) {
    final cities = selectedCountry.cities;

    // Nouvelle animation iOS-like pour la DailyPromoCard
    final double scale = (1 - (scrollOffset / 500)).clamp(0.9, 1.0);
    final double translateY = -(scrollOffset / 4).clamp(0.0, 40.0);
    final double opacity = (1 - (scrollOffset / 200)).clamp(0.6, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
    appBar: PreferredSize(
  preferredSize: const Size.fromHeight(60), // hauteur réduite
  child: SafeArea(
    bottom: false, // on garde que la sécurité du haut
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // réduit le vertical
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/studapart_long_logo.png",
            width: MediaQuery.of(context).size.width * 0.33,
            height: 36,
            fit: BoxFit.contain,
          ),
          Rental(isDossierComplet: true),
        ],
      ),
    ),
  ),
),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Sélecteur de pays
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LocationSelector(
                selectedCountry: selectedCountry,
                onChangeCountry: (country) {
                  setState(() {
                    selectedCountry = country;
                  });
                },
              ),
            ),

          

            // Carte promo animée style iOS
            Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.center,
                child: Opacity(
                  opacity: opacity,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DailyPromoCard(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Section "Logements disponibles"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logements disponibles",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary[900] ,
                    ),
                  ),
                  Text(
                    "Voir tout",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary[900] ,
                    ),
                  ),
                ],
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                
                  childAspectRatio: 1,
                ),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return CityCard(
                    image: city.image,
                    title: city.name,
                    onTap: () => handleCityPress(city.name),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
