import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';

class Rental extends StatefulWidget {
  final bool isDossierComplet;

  const Rental({super.key, required this.isDossierComplet});

  @override
  State<Rental> createState() => _RentalState();
}

class _RentalState extends State<Rental> with SingleTickerProviderStateMixin {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool menuVisible = false;

  int messageCount = 3;        // 🔔 Messages non lus
  int notificationCount = 7;   // 🔔 Notifications

  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  Timer? _shakeTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.15), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.15), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.15, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // ⏱ Animation de secouement toutes les 3 secondes
    _shakeTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted && messageCount > 0) {
        _controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _shakeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

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
                onTap: toggleMenu,
              ),
              ListTile(
                title: const Text("Modifier"),
                onTap: toggleMenu,
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
    bool shake = false, // option secouement
  }) {
    Widget iconWidget = Center(child: Icon(icon, size: 24, color: color));

    if (shake) {
      iconWidget = AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _shakeAnimation.value,
            child: child,
          );
        },
        child: iconWidget,
      );
    }

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
              child: iconWidget,
            ),
          ),
        ),

        // 🔴 Badge
        if (badgeCount > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
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
        // 🔔 Messages avec secouement périodique
        buildCircleIcon(
          icon: Iconsax.sms,
          color: AppColors.quadrary[900]!,
          badgeCount: messageCount,
          shake: true,
          onTap: () {
            setState(() {
              messageCount = 0;
            });
          },
        ),

        // 🔔 Notifications (ancien cœur)
        buildCircleIcon(
          icon: Iconsax.notification,
          color: AppColors.quadrary[900]!,
          badgeCount: notificationCount,
          onTap: () {
            setState(() {
              notificationCount =
                  (notificationCount > 0) ? notificationCount - 1 : 0;
            });
          },
        ),

        // 🍔 Menu
        buildCircleIcon(
          key: _menuKey,
          icon: Iconsax.more,
          color: AppColors.quadrary[900]!,
          onTap: toggleMenu,
        ),
      ],
    );
  }
}
