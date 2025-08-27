import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/ui/circle_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          CircleIcon(
            icon: Icons.share,
            color: AppColors.quadrary[900]!,
            // ignore: avoid_print
            onTap: () => print("Partager le profil"),
            size: 40,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ProfileHeader(),
            SizedBox(height: 20),
            PersonalInfoSection(),
            SizedBox(height: 20),
            RentalInfoSection(),
            SizedBox(height: 20),
            DocumentsSection(),
            SizedBox(height: 20),
            SettingsSection(),
          ],
        ),
      ),
    );
  }
}

/// Header avec photo et nom
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/user.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kevin Dissang",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Ligne Email + Icône de modification à droite
            Row(
              children: [
                const Text(
                  "dissangkevin@yahoo.com",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    // Ici tu pourras ouvrir un modal ou une page pour modifier l’email
                    print("Modifier l'email");
                  },
                  child: const Icon(Icons.edit, size: 16, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 4),
            const Text(
              "+237 6 97 64 54 15",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}

/// Informations personnelles
class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Informations personnelles",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          InfoRow(label: "Date de naissance", value: "01/01/1995"),
          InfoRow(label: "Statut", value: "Locataire actif"),
        ],
      ),
    );
  }
}

/// Infos location
class RentalInfoSection extends StatelessWidget {
  const RentalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Infos location",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          InfoRow(label: "Logement actuel", value: "Appartement 3 pièces"),
          InfoRow(label: "Loyer mensuel", value: "350€"),
          InfoRow(label: "Historique locations", value: "2 appartements"),
          InfoRow(label: "Favoris", value: "5 logements"),
        ],
      ),
    );
  }
}

/// Documents et Paiements
class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Documents & Paiements",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          InfoRow(label: "Contrat de location", value: "Télécharger"),
          InfoRow(label: "Factures", value: "Voir l'historique"),
        ],
      ),
    );
  }
}

/// Paramètres et actions
class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Paramètres & Actions",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoRow(label: "Changer mot de passe", value: ""),
          const InfoRow(label: "Notifications", value: "Email & Push"),
          GestureDetector(
            // ignore: avoid_print
            onTap: () => print("Déconnexion"),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Se déconnecter", style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget réutilisable pour les sections
class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Widget réutilisable pour afficher une ligne d'information
class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.primary[300])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
