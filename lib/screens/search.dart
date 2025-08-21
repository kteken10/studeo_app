import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/custom_app_bar.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // hauteur de ton appbar
        child: CustomAppBar(
         isDossierComplet: true,
        ),
      ),
      body: const Center(
        child: Text(
          "🔍 Search Screen Content",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
