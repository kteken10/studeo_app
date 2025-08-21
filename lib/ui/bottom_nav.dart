import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/screens/home.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  // Liste des icônes outline (non sélectionnées)
  final List<IconData> _iconsOutline = [
    Iconsax.home,
    Iconsax.search_normal,
    Iconsax.message,
    Iconsax.user,
  ];

  // Liste des icônes bold/remplies (sélectionnées)
  final List<IconData> _iconsBold = [
    Iconsax.home5,
     Iconsax.search_normal2,
    Iconsax.message5,
    Iconsax.user5,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fond de l'écran
      body: Center(
        child: HomeScreen(), // ton écran principal
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.ternary[900], // fond du nav
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_iconsOutline.length, (index) {
              final bool isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SizedBox(
                    width: 26,
                    height: 26,
                    child: Icon(
                      isSelected ? _iconsBold[index] : _iconsOutline[index],
                      color: isSelected ? Colors.black : Colors.white,
                      size: 22, // taille réduite pour respirer dans la box
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
