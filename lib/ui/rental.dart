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
                  // Action "Ouvrir le dossier"
                },
              ),
              ListTile(
                title: const Text("Modifier"),
                onTap: () {
                  toggleMenu();
                  // Action "Modifier"
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
    VoidCallback? onTap,
    Key? key,
  }) {
    return Container(
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
        color: Colors.transparent, // pour laisser apparaître le blanc
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: AppColors.primary[900]!.withOpacity(0.2), // effet ripple
          highlightColor: Colors.grey.withOpacity(0.1), // petit effet appuyé
          onTap: onTap,
          child: Center(
            child: Icon(icon, size: 24, color: color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Message
        buildCircleIcon(
          icon: Iconsax.sms,
          color: AppColors.quadrary[900]!,
          onTap: () {
            // Action message
          },
        ),
        // Coeur
        buildCircleIcon(
          icon: Iconsax.heart,
          color: AppColors.quadrary[900]!,
          onTap: () {
            // Action like
          },
        ),
        // Menu Burger (avec overlay)
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
