import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';
import 'package:studeo/ui/circle_icon.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false; // état du thème
  bool isPasswordVisible = false; // état visibilité mot de passe

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    print(isDarkMode ? "Dark Mode activé" : "Light Mode activé");
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: CircleIcon(
          icon: Icons.arrow_back,
          color: AppColors.quadrary[900]!,
          onTap: () => Navigator.pop(context),
          size: 22,
        ),
        title: const Text(
          "Mon profil",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          CircleIcon(
            icon: Icons.share,
            color: AppColors.quadrary[900]!,
            onTap: () => print("Partager le profil"),
            size: 40,
          ),
          CircleIcon(
            icon: isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
            color: AppColors.quadrary[900]!,
            onTap: _toggleTheme,
            size: 40,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 20),
          
            const RentalInfoSection(),
            
                const SizedBox(height: 20),
             
             const PersonalInfoSection(), 
            const SizedBox(height: 20),
            const DocumentsSection(),
           
           
            const SizedBox(height: 20),
            SettingsSection(
              isPasswordVisible: isPasswordVisible,
              onTogglePassword: _togglePasswordVisibility,
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.ternary[900]!.withOpacity(0.8), // Fond noir
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2), // bordure blanche
              image: const DecorationImage(
                image: AssetImage('assets/user.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Léa Martin",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // texte blanc
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => print("Modifier le profil"),
                      child: const Icon(Icons.edit, size: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "lea.martin@etudiant.fr",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 2),
                const Text(
                  "+33 6 00 00 00 00",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RentalInfoSection extends StatelessWidget {
  const RentalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoColumn(
            icon: Icons.attach_money,
            iconColor: AppColors.ternary[900]!,
            value: "350€",
            label: "Loyer mensuel",
          ),
          InfoColumn(
            icon: Icons.favorite,
            iconColor: AppColors.ternary[900]!,
            value: "2",
            label: "Favoris",
          ),
          InfoColumn(
            icon: Icons.history,
            iconColor: AppColors.ternary[900]!,
            value: "2",
            label: "Historique locations",
          ),
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const InfoColumn({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.1),
          ),
          child: Icon(icon, size: 26, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (label.isNotEmpty) const SizedBox(height: 4),
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
      ],
    );
  }
}

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            icon: Icons.description,
            label: "Contrat de location",
            value: "Télécharger",
          ),
          InfoRow(
            icon: Icons.receipt_long,
            label: "Factures",
            value: "Voir l'historique",
          ),
        ],
      ),
    );
  }
}

// Nouvelle section pour date de naissance et adresse
class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            icon: Icons.cake,
            label: "Date de naissance",
            value: "14/03/2004",
          ),
          InfoRow(
            icon: Icons.location_on,
            label: "Adresse",
            value: "Paris 10e, France",
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;

  const SettingsSection({
    super.key,
    required this.isPasswordVisible,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mot de passe avec icône œil
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock, size: 20, color: AppColors.primary[900]!),
                    const SizedBox(width: 8),
                    const Text("Mot de passe", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      isPasswordVisible ? "monPassword123" : "********",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onTogglePassword,
                      child: Icon(
                        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.primary[900]!,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const InfoRow(
            icon: Icons.notifications,
            label: "Notifications",
            value: "Email & Push",
          ),

          GestureDetector(
            onTap: () => print("Déconnexion"),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.logout, color: AppColors.warning[900]),
                  SizedBox(width: 8),
                  Text(
                    "Se déconnecter",
                    style: TextStyle(color: AppColors.warning[900], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: child,
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: AppColors.primary[900]!),
                const SizedBox(width: 8),
              ],
              Text(label, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
