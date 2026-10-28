import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';
import 'package:studeo/data/citie.dart';

// Modals
import 'package:studeo/ui/type_logement_modal.dart';
import 'package:studeo/ui/budget_modal.dart';
import 'package:studeo/ui/rooms_modal.dart';
import 'package:studeo/ui/date_modal.dart';

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

  final List<String> _selectedCities = [];
  List<String> _filteredCities = [];

  // Filtres
  DateTime? _selectedDate;
  List<String> _selectedTypes = [];
  RangeValues _priceRange = const RangeValues(300, 1200);
  int _rooms = 1;

  final List<String> _types = const [
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
        _filteredCities =
            cities.where((city) => city.toLowerCase().contains(query)).toList();
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

  // ---- Gestion recherche ----
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
    if (!_selectedCities.contains(city)) {
      setState(() => _selectedCities.add(city));
    }
    _searchController.clear();
    _filteredCities = List.from(cities);
  }

  void _removeCity(String city) {
    setState(() => _selectedCities.remove(city));
  }

  // ---- Filtres ----
  Future<void> _pickDate() async {
    final picked = await showDateModal(context);
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _pickType() {
  showModalBottomSheet(
    context: context,
    builder: (_) => TypeLogementModal(
      types: _types,
      initialSelected: _selectedTypes, // <-- AJOUTE CETTE LIGNE
      onSelected: (types) => setState(() => _selectedTypes = types),
    ),
  );
}

  void _pickPrice() {
    showModalBottomSheet(
      context: context,
      builder: (_) => BudgetModal(
        initialRange: _priceRange,
        onChanged: (range) => setState(() => _priceRange = range),
      ),
    );
  }

  void _pickRooms() {
    showModalBottomSheet(
      context: context,
      builder: (_) => RoomsModal(
        initialRooms: _rooms,
        onChanged: (rooms) => setState(() => _rooms = rooms),
      ),
    );
  }

  // ---- UI ----
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        if (_isSearching && _searchController.text.isNotEmpty)
          _buildCitySuggestions(),
        if (_selectedCities.isNotEmpty) _buildSelectedCities(),
        const SizedBox(height: 12),

        // Icônes filtres
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _filterIcon(Icons.calendar_today, "Date", _pickDate),
            _filterIcon(Icons.apartment, "Type", _pickType),
            _filterIcon(Icons.euro, "Budget", _pickPrice),
            _filterIcon(Icons.meeting_room, "Nb pièce", _pickRooms),
          ],
        ),

        // Résumé des filtres
        if (_hasFilters) _buildFiltersSummary(),
      ],
    );
  }

  // ---- Widgets UI ----
  Widget _buildSearchBar() {
    return Container(
      height: 50,
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
                      hintText: widget.hintText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                  )
                : null,
          ),
          if (_isSearching) const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.primary[900],
            radius: _isSearching ? 8 : 14,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
                color: _isSearching ? AppColors.warning[900] : AppColors.white,
                size: _isSearching ? 14: 20,
              ),
              onPressed: _toggleSearch,
            ),
          ),
        ],
      ),
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
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
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
    return SizedBox(
      // margin: const EdgeInsets.only(top: 8),
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedCities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final city = _selectedCities[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary[900]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(city, style: const TextStyle(color: Colors.black)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => _removeCity(city),
                  child: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFiltersSummary() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          children: [
            if (_selectedDate != null)
              Chip(
                label: Text(
                  "Dès le ${_selectedDate!.day}/${_selectedDate!.month}",
                ),
                backgroundColor: AppColors.white,
              ),
            if (_selectedTypes.isNotEmpty)
              ..._selectedTypes.map((type) => Chip(label: Text(type))),
            Chip(
              label: Text(
                "${_priceRange.start.toInt()}€-${_priceRange.end.toInt()}€",
              ),
              backgroundColor: AppColors.white,
            ),
            Chip(
              label: Text("$_rooms pièce(s)"),
              backgroundColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasFilters =>
      _selectedDate != null ||
      _selectedTypes.isNotEmpty ||
      _priceRange.start != 300 ||
      _priceRange.end != 1200 ||
      _rooms != 1;
}
