import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import '../data/locations.dart';

class LocationSelector extends StatefulWidget {
  final Country selectedCountry;
  final ValueChanged<Country> onChangeCountry;

  const LocationSelector({
    super.key,
    required this.selectedCountry,
    required this.onChangeCountry,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Partie gauche
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: AppColors.primary[900]),
            const SizedBox(width: 4),
            Text(
              "Logement en",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primary[900],
              ),
            ),
          ],
        ),

        // Partie droite (menu)
        PopupMenuButton<Country>(
          color: Colors.white, // ✅ fond du menu en blanc
          onSelected: (Country value) {
            widget.onChangeCountry(value);
          },
          itemBuilder: (BuildContext context) {
            return countries.map((Country country) {
              return PopupMenuItem<Country>(
                value: country,
                child: Row(
                  children: [
                    Image.asset(
                      country.flag,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      country.name,
                      style: TextStyle(
                        color: AppColors.primary[900],
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
          child: Row(
            children: [
              Image.asset(
                widget.selectedCountry.flag,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 6),
              Text(
                widget.selectedCountry.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary[900],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
