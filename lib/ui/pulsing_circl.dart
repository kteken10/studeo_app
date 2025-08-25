import 'package:flutter/material.dart';
class PulsatingCircle extends StatefulWidget {
  final Color color;
  const PulsatingCircle({super.key, required this.color});

  @override
  State<PulsatingCircle> createState() => _PulsatingCircleState();
}

class _PulsatingCircleState extends State<PulsatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double size = 10 + (_controller.value * 6); // rayon du cercle
        double opacity = 0.5 + (_controller.value * 0.5); // pulsation
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
