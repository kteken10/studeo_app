import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/screens/notification.dart';

class Rental extends StatefulWidget {
  final bool isDossierComplet;

  const Rental({super.key, required this.isDossierComplet});

  @override
  State<Rental> createState() => _RentalState();
}

class _RentalState extends State<Rental> with TickerProviderStateMixin {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool menuVisible = false;

  int messageCount = 3;
  int notificationCount = 7;

  late AnimationController _messageController;
  late Animation<double> _messageShake;

  late AnimationController _notificationController;
  late Animation<double> _notificationShake;

  final Random _random = Random();
  Timer? _messageTimer;
  Timer? _notificationTimer;

  @override
  void initState() {
    super.initState();

    // Animation messages
    _messageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _messageShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _messageController, curve: Curves.easeInOut));

    // Animation notifications
    _notificationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _notificationShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _notificationController, curve: Curves.easeInOut));

    // Lancer les secouements aléatoires
    _scheduleNextMessageShake();
    _scheduleNextNotificationShake();
  }

  void _scheduleNextMessageShake() {
    if (!mounted) return;
    final duration = Duration(seconds: 2 + _random.nextInt(3)); // 2 à 4 sec
    _messageTimer = Timer(duration, () {
      if (mounted && messageCount > 0) {
        _messageController.forward(from: 0);
      }
      _scheduleNextMessageShake(); // replanifier
    });
  }

  void _scheduleNextNotificationShake() {
    if (!mounted) return;
    final duration = Duration(seconds: 3 + _random.nextInt(4)); // 3 à 6 sec
    _notificationTimer = Timer(duration, () {
      if (mounted && notificationCount > 0) {
        _notificationController.forward(from: 0);
      }
      _scheduleNextNotificationShake(); // replanifier
    });
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    _notificationTimer?.cancel();
    _messageController.dispose();
    _notificationController.dispose();
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
    Animation<double>? shakeAnimation,
  }) {
    Widget iconWidget = Center(child: Icon(icon, size: 24, color: color));

    if (shakeAnimation != null) {
      iconWidget = AnimatedBuilder(
        animation: shakeAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: shakeAnimation.value,
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
        buildCircleIcon(
          icon: Iconsax.sms,
          color: AppColors.quadrary[900]!,
          badgeCount: messageCount,
          shakeAnimation: _messageShake,
          onTap: () {
            setState(() {
              messageCount = 0;
            });
          },
        ),
        buildCircleIcon(
          icon: Iconsax.notification,
          color: AppColors.quadrary[900]!,
          badgeCount: notificationCount,
          shakeAnimation: _notificationShake,
          onTap: () {
            setState(() {
              notificationCount =
                  (notificationCount > 0) ? notificationCount - 1 : 0;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            );
          },
        ),
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
