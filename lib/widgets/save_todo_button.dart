import 'package:flutter/material.dart';

class SaveTodoButton extends StatelessWidget {
  final Function saveTodoFn;
  const new({super.key, required this.saveTodoFn, required this._title});

  final String _title;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _title.isEmpty || _title.trim() == ""
          ? null
          : () {
              saveTodoFn();
              Navigator.pop(context);
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.save),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Save Todo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
