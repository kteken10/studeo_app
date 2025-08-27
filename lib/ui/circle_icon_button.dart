import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final BoxShadow? shadow;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.size = 36,
    this.iconSize = 18,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
  width: size,
  height: size,
  alignment: Alignment.center, 
  decoration: BoxDecoration(
    color: backgroundColor,
    shape: BoxShape.circle,
    boxShadow: shadow != null ? [shadow!] : [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.2),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Icon(
    icon,
    color: iconColor,
    size: iconSize,
  ),
)

    );
  }
}
