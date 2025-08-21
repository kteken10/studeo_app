import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';

class Rental extends StatefulWidget {
  final bool isDossierComplet;

  const Rental({super.key, required this.isDossierComplet});

  @override
  State<Rental> createState() => _RentalState();
}

class _RentalState extends State<Rental> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool menuVisible = false;

  int messageCount = 3;   // 🔔 Exemple : 3 messages non lus
  int favoriteCount = 7;  // ❤️ Exemple : 7 favoris

  void toggleMenu() {
    if (menuVisible) {
      _overlayEntry?.remove();
      menuVisible = false;
    } else {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
      menuVisible = true;
    }
    setState(() {});
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + renderBox.size.height + 5,
        left: offset.dx,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Ouvrir le dossier"),
                onTap: () {
                  toggleMenu();
                },
              ),
              ListTile(
                title: const Text("Modifier"),
                onTap: () {
                  toggleMenu();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleIcon({
    required IconData icon,
    required Color color,
    int badgeCount = 0,
    VoidCallback? onTap,
    Key? key,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          key: key,
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary[900]!.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              splashColor: AppColors.primary[900]!.withOpacity(0.2),
              highlightColor: Colors.grey.withOpacity(0.1),
              onTap: onTap,
              child: Center(
                child: Icon(icon, size: 24, color: color),
              ),
            ),
          ),
        ),

        // 🔴 Badge (seulement si badgeCount > 0)
        if (badgeCount > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Message avec badge
        buildCircleIcon(
          icon: Iconsax.sms,
          color: AppColors.quadrary[900]!,
          badgeCount: messageCount,
          onTap: () {
            setState(() {
              messageCount = 0; // Exemple : remettre à zéro après lecture
            });
          },
        ),

        // Favoris avec badge
        buildCircleIcon(
          icon: Iconsax.heart,
          color: AppColors.quadrary[900]!,
          badgeCount: favoriteCount,
          onTap: () {
            setState(() {
              favoriteCount = (favoriteCount > 0) ? favoriteCount - 1 : 0;
            });
          },
        ),

        // Menu Burger (sans badge)
        buildCircleIcon(
          key: _menuKey,
          icon: Iconsax.menu,
          color: AppColors.quadrary[900]!,
          onTap: toggleMenu,
        ),
      ],
    );
  }
}
