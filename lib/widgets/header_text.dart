import 'package:flutter/material.dart';
import 'package:shiuli/utils/theme.dart';

class HeaderText extends StatelessWidget {
  final String text;
  const new(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppTheme.lightTheme.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
