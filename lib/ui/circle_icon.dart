import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final double size;

  const CircleIcon({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
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
          // ignore: deprecated_member_use
          splashColor: AppColors.primary[900]!.withOpacity(0.2),
          // ignore: deprecated_member_use
          highlightColor: Colors.grey.withOpacity(0.1),
          onTap: onTap,
          child: Center(
            child: Icon(icon, size: 24, color: color),
          ),
        ),
      ),
    );
  }
}
