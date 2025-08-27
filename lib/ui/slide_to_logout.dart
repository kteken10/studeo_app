import 'package:flutter/material.dart';

class SlideToLogout extends StatefulWidget {
  final VoidCallback onLogout;

  const SlideToLogout({super.key, required this.onLogout});

  @override
  // ignore: library_private_types_in_public_api
  _SlideToLogoutState createState() => _SlideToLogoutState();
}

class _SlideToLogoutState extends State<SlideToLogout> {
  double _dragPosition = 0.0;
  bool _loggedOut = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Texte centré
          Center(
            child: Text(
              _loggedOut ? "Déconnecté" : "Glisser pour se déconnecter",
              style: TextStyle(
                color: _loggedOut ? Colors.red : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Bouton circulaire qu’on glisse
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;
                  _dragPosition = _dragPosition.clamp(
                    0.0,
                    MediaQuery.of(context).size.width - 80,
                  );
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition > MediaQuery.of(context).size.width * 0.6) {
                  setState(() {
                    _loggedOut = true;
                  });
                  widget.onLogout();
                } else {
                  setState(() {
                    _dragPosition = 0.0;
                  });
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.power_settings_new, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
