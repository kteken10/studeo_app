import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/screens/favorite.dart';
import 'package:studapart_mobile/screens/home.dart';
import 'package:studapart_mobile/screens/profile.dart';
import 'package:studapart_mobile/screens/search.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Iconsax.home,
    Iconsax.search_normal,
    Iconsax.heart, 
    Iconsax.user,
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: _screens[_selectedIndex], 
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.ternary[900], 
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
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
                      _icons[index],
                      color: isSelected ? Colors.black : Colors.white,
                      size: 22,
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
