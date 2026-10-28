import 'package:flutter/material.dart';
import 'package:studeo/ui/button.dart';

class RoomsModal extends StatefulWidget {
  final int initialRooms;
  final ValueChanged<int> onChanged;

  const RoomsModal({
    super.key,
    required this.initialRooms,
    required this.onChanged,
  });

  @override
  State<RoomsModal> createState() => _RoomsModalState();
}

class _RoomsModalState extends State<RoomsModal> {
  late int _rooms;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _rooms = widget.initialRooms;
    _controller = TextEditingController(text: _rooms.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRoomsChanged(String value) {
    final rooms = int.tryParse(value);
    if (rooms != null && rooms > 0) {
      setState(() {
        _rooms = rooms;
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  if (_rooms > 1) {
                    setState(() {
                      _rooms--;
                      _controller.text = _rooms.toString();
                    });
                  }
                },
              ),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  onChanged: _onRoomsChanged,
                  onEditingComplete: () {
                    if (_rooms < 1) {
                      setState(() {
                        _rooms = 1;
                        _controller.text = "1";
                      });
                    }
                  },
                ),
              ),
              Text("pièce(s)", style: const TextStyle(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  setState(() {
                    _rooms++;
                    _controller.text = _rooms.toString();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            label: "Valider",
            width: double.infinity,
            onPressed: () {
              widget.onChanged(_rooms);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}