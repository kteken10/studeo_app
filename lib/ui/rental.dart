import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/screens/notification.dart';
import 'package:studapart_mobile/ui/circle_icon.dart';

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

    _messageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _messageShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _messageController, curve: Curves.easeInOut));

    _notificationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _notificationShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _notificationController, curve: Curves.easeInOut));

    _scheduleNextMessageShake();
    _scheduleNextNotificationShake();
  }

  void _scheduleNextMessageShake() {
    if (!mounted) return;
    final duration = Duration(seconds: 2 + _random.nextInt(3));
    _messageTimer = Timer(duration, () {
      if (mounted && messageCount > 0) _messageController.forward(from: 0);
      _scheduleNextMessageShake();
    });
  }

  void _scheduleNextNotificationShake() {
    if (!mounted) return;
    final duration = Duration(seconds: 3 + _random.nextInt(4));
    _notificationTimer = Timer(duration, () {
      if (mounted && notificationCount > 0) _notificationController.forward(from: 0);
      _scheduleNextNotificationShake();
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
    RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Message Icon avec badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _messageShake,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _messageShake.value,
                  child: child,
                );
              },
              child: CircleIcon(
                icon: Iconsax.sms,
                color: AppColors.quadrary[900]!,
                onTap: () => setState(() => messageCount = 0),
              ),
            ),
            if (messageCount > 0)
              Positioned(
                right: 4,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Center(
                    child: Text(
                      messageCount.toString(),
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
        ),

        const SizedBox(width: 12),

        // Notification Icon avec badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _notificationShake,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _notificationShake.value,
                  child: child,
                );
              },
              child: CircleIcon(
                icon: Iconsax.notification,
                color: AppColors.quadrary[900]!,
                onTap: () {
                  setState(() => notificationCount = (notificationCount > 0) ? notificationCount - 1 : 0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationScreen()),
                  );
                },
              ),
            ),
            if (notificationCount > 0)
              Positioned(
                right: 4,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
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
        ),

        const SizedBox(width: 12),

        // Menu Icon
        CircleIcon(
          key: _menuKey,
          icon: Iconsax.more,
          color: AppColors.quadrary[900]!,
          onTap: toggleMenu,
        ),
      ],
    );
  }
}
