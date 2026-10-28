import 'package:flutter/material.dart';
import 'package:studeo/constants/colors.dart';
import 'package:studeo/ui/button.dart'; // <-- Ajoute cet import

class BudgetModal extends StatefulWidget {
  final RangeValues initialRange;
  final ValueChanged<RangeValues> onChanged;

  const BudgetModal({
    super.key,
    required this.initialRange,
    required this.onChanged,
  });

  @override
  State<BudgetModal> createState() => _BudgetModalState();
}

class _BudgetModalState extends State<BudgetModal> {
  late RangeValues _range;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _range = widget.initialRange;
    _minController = TextEditingController(text: _range.start.toInt().toString());
    _maxController = TextEditingController(text: _range.end.toInt().toString());
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _onMinChanged(String value) {
    final min = int.tryParse(value) ?? _range.start.toInt();
    final max = _range.end.toInt();
    if (min <= max && min >= 100 && min <= 3000) {
      setState(() {
        _range = RangeValues(min.toDouble(), _range.end);
      });
    }
  }

  void _onMaxChanged(String value) {
    final max = int.tryParse(value) ?? _range.end.toInt();
    final min = _range.start.toInt();
    if (max >= min && max >= 100 && max <= 3000) {
      setState(() {
        _range = RangeValues(_range.start, max.toDouble());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Min (€)"),
                  onChanged: (value) {
                    _onMinChanged(value);
                  },
                  onEditingComplete: () {
                    final min = int.tryParse(_minController.text) ?? _range.start.toInt();
                    if (min < 100) _minController.text = "100";
                    if (min > _range.end) _minController.text = _range.end.toInt().toString();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Max (€)"),
                  onChanged: (value) {
                    _onMaxChanged(value);
                  },
                  onEditingComplete: () {
                    final max = int.tryParse(_maxController.text) ?? _range.end.toInt();
                    if (max > 3000) _maxController.text = "3000";
                    if (max < _range.start) _maxController.text = _range.start.toInt().toString();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text("Prix: ${_range.start.toInt()}€ - ${_range.end.toInt()}€"),
          RangeSlider(
            min: 100,
            max: 3000,
            divisions: 30,
            activeColor: AppColors.secondary[900],
            values: _range,
            onChanged: (values) {
              setState(() {
                _range = values;
                _minController.text = values.start.toInt().toString();
                _maxController.text = values.end.toInt().toString();
              });
            },
          ),
          const SizedBox(height: 16),
          AppButton(
            label: "Valider",
            width: double.infinity,
            onPressed: () {
              widget.onChanged(_range);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}