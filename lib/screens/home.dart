import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/data/locations.dart';
import 'package:studapart_mobile/ui/city_card.dart';
import 'package:studapart_mobile/ui/custom_app_bar.dart';
import 'package:studapart_mobile/ui/daily_promo_card.dart';
import 'package:studapart_mobile/ui/location_selector.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double scrollOffset = 0;
  Country selectedCountry = countries.first;

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
  }

  @override
  Widget build(BuildContext context) {
    final cities = selectedCountry.cities;

    final double scale = (1 - (scrollOffset / 500)).clamp(0.9, 1.0);
    final double translateY = -(scrollOffset / 4).clamp(0.0, 40.0);
    final double opacity = (1 - (scrollOffset / 200)).clamp(0.6, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(
        isDossierComplet: true, // Remplacez par la logique appropriée
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 8),
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
                      color: AppColors.primary[900],
                    ),
                  ),
                  Text(
                    "Voir tout",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary[900],
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
