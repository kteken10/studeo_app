import 'package:flutter/material.dart';
import 'package:studapart_mobile/constants/colors.dart';
import 'package:studapart_mobile/data/citie.dart';


class SearchCard extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  const SearchCard({
    super.key,
    this.controller,
    this.hintText = "Ville, Code postal...",
  });

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool _isSearching = false;
  late final TextEditingController _searchController;
  String? _selectedCity;

  // Liste filtrée basée sur l'import
  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
    _filteredCities = List.from(cities); 

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredCities = cities
            .where((city) => city.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _searchController.dispose();
    }
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _selectedCity = null;
      }
    });
  }

  void _selectCity(String city) {
    setState(() {
      _selectedCity = city;
      _searchController.text = city;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary[900]!.withOpacity(0.1),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isSearching ? MediaQuery.of(context).size.width - 250 : 0,
                height: 25,
                curve: Curves.easeInOut,
                child: _isSearching
                    ? TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                             borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: widget.hintText,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      )
                    : null,
              ),
              if (_isSearching) const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColors.primary[900],
                radius: _isSearching ? 8 : 16,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    _isSearching ? Icons.close : Icons.search,
                    color: _isSearching
                        ? AppColors.warning[900]
                        : AppColors.white,
                    size: _isSearching ? 12 : 20,
                  ),
                  onPressed: _toggleSearch,
                ),
              ),
            ],
          ),
        ),

        // Liste déroulante des suggestions
        if (_isSearching && _searchController.text.isNotEmpty)
        if (_isSearching && _searchController.text.isNotEmpty)
  Align(
    alignment: Alignment.centerLeft, // force à gauche
    child: Container(
      width: MediaQuery.of(context).size.width * 0.5, // moitié de l'écran
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(maxHeight: 200),
      child: _filteredCities.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCities.length,
              itemBuilder: (context, index) {
                final city = _filteredCities[index];
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(city),
                  onTap: () => _selectCity(city),
                );
              },
            )
          : const Center(
              child: Text(
                "Pas de résultats pour cette recherche.",
                style: TextStyle(color: Colors.black54),
              ),
            ),
    ),
  ),

        // Badge pour la ville sélectionnée
        if (_selectedCity != null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedCity!,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCity = null;
                      _searchController.clear();
                    });
                  },
                  child: const Icon(Icons.close, size: 16),
                )
              ],
            ),
          ),
      ],
    );
  }
}
