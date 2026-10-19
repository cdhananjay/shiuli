import 'package:flutter/material.dart';

class DatePickerButton extends StatelessWidget {
  final Function onPressed;
  const new({super.key, required this.onPressed, required this._date});

  final String _date;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(Icons.calendar_month_outlined, size: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
