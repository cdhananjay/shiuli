import 'package:flutter/material.dart';

class TimePickerButton extends StatelessWidget {
  final Function onPressed;
  const new({super.key, required this.onPressed, required this._selectedTime});

  final TimeOfDay _selectedTime;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(Icons.watch_later_outlined, size: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _selectedTime.format(context),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
