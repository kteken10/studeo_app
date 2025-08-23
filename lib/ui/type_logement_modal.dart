import 'package:flutter/material.dart';
import 'package:studapart_mobile/ui/button.dart';

class TypeLogementModal extends StatefulWidget {
  final List<String> types;
  final ValueChanged<List<String>> onSelected;
  final List<String> initialSelected;

  const TypeLogementModal({
    super.key,
    required this.types,
    required this.onSelected,
    this.initialSelected = const [],
  });

  @override
  State<TypeLogementModal> createState() => _TypeLogementModalState();
}

class _TypeLogementModalState extends State<TypeLogementModal> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    // ✅ On récupère les sélections déjà faites si elles existent
    _selected = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choisir un type de logement",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ✅ Liste déroulante avec cases à cocher
            Flexible(
              fit: FlexFit.loose,
              child: ListView(
                shrinkWrap: true,
                children: widget.types.map((t) {
                  return CheckboxListTile(
                    value: _selected.contains(t),
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          // ✅ Empêcher les doublons
                          if (!_selected.contains(t)) {
                            _selected.add(t);
                          }
                        } else {
                          _selected.remove(t);
                        }
                      });
                    },
                    title: Text(t),
                    secondary: const Icon(Icons.home_work_outlined),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Bouton valider
            AppButton(
              label: "Valider",
              width: double.infinity,
              onPressed: () {
                widget.onSelected(_selected);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
