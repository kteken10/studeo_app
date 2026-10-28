import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';

/// Logo Studéo : une maison dans un carré arrondi, puis le nom.
class StudeoLogo extends StatelessWidget {
  final double size;

  const StudeoLogo({super.key, this.size = 34});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary[900],
            borderRadius: BorderRadius.circular(size * 0.3),
          ),
          child: Icon(Icons.home_rounded, color: Colors.white, size: size * 0.62),
        ),
        SizedBox(width: size * 0.28),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Stud', style: TextStyle(color: AppColors.primary[900])),
              TextSpan(text: 'éo', style: TextStyle(color: AppColors.secondary[900])),
            ],
          ),
          style: TextStyle(
            fontSize: size * 0.66,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
