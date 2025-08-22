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

  List<String> _selectedCities = [];
  List<String> _filteredCities = [];

  // Ajouts pour les filtres
  DateTime? _selectedDate;
  String? _selectedType;
  RangeValues _priceRange = const RangeValues(300, 1200);
  int _rooms = 1;

  final List<String> _types = [
    "Logement entier",
    "Colocation",
    "Coliving",
    "Chambre chez l'habitant",
    "Logement contre services"
  ];

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
        _filteredCities = List.from(cities);
      }
    });
  }

  void _selectCity(String city) {
    setState(() {
      if (!_selectedCities.contains(city)) {
        _selectedCities.add(city);
      }
      _searchController.clear();
      _filteredCities = List.from(cities);
    });
  }

  void _removeCity(String city) {
    setState(() {
      _selectedCities.remove(city);
    });
  }

  // ---- Filtres ----
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      initialDate: now,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickType() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        padding: const EdgeInsets.all(16),
        children: _types.map((t) {
          return ListTile(
            leading: const Icon(Icons.home_work_outlined),
            title: Text(t),
            onTap: () {
              setState(() {
                _selectedType = t;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  void _pickPrice() {
    showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Prix: ${_priceRange.start.toInt()}€ - ${_priceRange.end.toInt()}€"),
                RangeSlider(
                  min: 100,
                  max: 3000,
                  divisions: 30,
                  values: _priceRange,
                  onChanged: (values) {
                    setModalState(() => _priceRange = values);
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Valider"),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _pickRooms() {
    showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (_rooms > 1) {
                      setModalState(() => _rooms--);
                      setState(() {});
                    }
                  },
                ),
                Text("$_rooms pièce(s)", style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setModalState(() => _rooms++);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Barre de recherche ville
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
                width: _isSearching
                    ? MediaQuery.of(context).size.width - 250
                    : 0,
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(color: Colors.white),
                          ),
                          hintText: widget.hintText,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
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

        // 📌 Suggestions villes
        if (_isSearching && _searchController.text.isNotEmpty)
          _buildCitySuggestions(),

        // 🏷️ Villes sélectionnées
        if (_selectedCities.isNotEmpty) _buildSelectedCities(),

        const SizedBox(height: 12),

        // 🎯 Icônes filtres
       Row(
  mainAxisAlignment: MainAxisAlignment.start, // ← icônes alignées à gauche
  children: [
   
    _filterIcon(Icons.calendar_today, "Date", _pickDate),
    const SizedBox(width: 32), // espacement entre les icônes
    _filterIcon(Icons.apartment, "Type", _pickType),
    const SizedBox(width: 32),
    _filterIcon(Icons.euro, "Prix", _pickPrice),
    const SizedBox(width: 32),
    _filterIcon(Icons.meeting_room, "Pièces", _pickRooms),
  ],
),

       // Résumé des filtres appliqués
if (_selectedDate != null || _selectedType != null || _rooms > 1)
  Padding(
    padding: const EdgeInsets.only(top: 12, left: 0), // ← ajout padding gauche
    child: Align(
      alignment: Alignment.centerLeft, // ← garantit l'alignement à gauche
      child: Wrap(
        spacing: 8,
        children: [
          if (_selectedDate != null)
            Chip(
              label: Text("Dès le ${_selectedDate!.day}/${_selectedDate!.month}"),
              backgroundColor: AppColors.white,
            ),
          if (_selectedType != null) Chip(label: Text(_selectedType!)),
          Chip(label: Text("${_priceRange.start.toInt()}€-${_priceRange.end.toInt()}€"),backgroundColor: AppColors.white,),
          Chip(label: Text("$_rooms pièce(s)"),backgroundColor: AppColors.white,),
        ],
      ),
    ),
  ),

      ],
    );
  }

  Widget _filterIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: AppColors.primary[900]),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCitySuggestions() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
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
    );
  }

  Widget _buildSelectedCities() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _selectedCities.map((city) {
            return Container(
              margin: EdgeInsets.only(
                right: 8,
                left: _selectedCities.first == city ? 0 : 4,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary[900]!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(city, style: const TextStyle(color: Colors.black)),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _removeCity(city),
                    child: const Icon(Icons.close, size: 16),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
