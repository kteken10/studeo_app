import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/rental.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDossierComplet;

  const CustomAppBar({
    super.key,
    required this.isDossierComplet,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/studapart_long_logo.png",
              width: MediaQuery.of(context).size.width * 0.33,
              height: 36,
              fit: BoxFit.contain,
            ),
            Rental(isDossierComplet: isDossierComplet),
          ],
        ),
      ),
    );
  }

  // Obligatoire pour que ce widget puisse être utilisé dans appBar:
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
