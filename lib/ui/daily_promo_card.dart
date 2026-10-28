import 'package:flutter/material.dart'; 
import 'package:studeo/ui/button.dart';

class DailyPromoCard extends StatelessWidget {
  const DailyPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // coins arrondis appliqués à tout
        child: Stack(
          children: [
            // Image de fond
            Positioned.fill(
              child: Image.asset(
                'assets/branding_house.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // Overlay semi-transparent + contenu
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.25), // plus besoin de borderRadius ici
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Texte
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Trouvez un logement fiable",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Partout en France, en 2 clics !",
                          style: TextStyle(
                             fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Bouton + Partenaires
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Utilisation du AppButton
                        AppButton(
                          label: "Commencer",
                          width: 100,
                          onPressed: () {
                            print("Bouton Commencer pressé !");
                          },
                        ),

                        // Logos partenaires
                        Row(
                          children: [
                            const Text(
                              "Inclus :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Partenaire 1
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.shield_outlined, size: 14, color: Colors.black87),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "Assurance",
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),

                            // Séparateur vertical
                            Container(
                              width: 1,
                              height: 24,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.white,
                            ),

                            // Partenaire 2
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified_user_outlined, size: 14, color: Colors.black87),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "Garant",
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
