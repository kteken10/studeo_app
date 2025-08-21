import 'package:flutter/material.dart';

class HeaderProfile extends StatelessWidget {
  final String userName;
  final String profileImageUrl;
  final bool isDossierComplete;
  final VoidCallback onEdit;
  final VoidCallback onMenuTap;

  const HeaderProfile({
    super.key,
    required this.userName,
    required this.profileImageUrl,
    this.isDossierComplete = false,
    required this.onEdit,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profil + Info
        Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Image de profil
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),

                // Bouton édition
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onEdit,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                // Badge garant
                Positioned(
                  top: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.shield, size: 14, color: Colors.white),
                  ),
                ),

                // Badge vérifié
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check_circle, size: 14, color: Colors.white),
                  ),
                ),

                // Score circulaire autour du profil
                Positioned.fill(
                  child: CustomPaint(
                    painter: CircleScorePainter(),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Infos utilisateur
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  isDossierComplete ? "Dossier complet" : "Dossier incomplet",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDossierComplete ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),

     
      ],
    );
  }
}

// Peinture du cercle autour du profil
class CircleScorePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orangeAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
