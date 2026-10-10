import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  String get _appBarTitle {
    final timeOfDay = TimeOfDay.now();
    if (timeOfDay.hour >= 3 && timeOfDay.hour < 12) {
      return "Good morning 🌼";
    } else if (timeOfDay.hour >= 12 && timeOfDay.hour <= 16) {
      return "Good afternoon 🌿";
    } else if (timeOfDay.hour > 16 && timeOfDay.hour < 20) {
      return "Good evening 🌷";
    }
    return "Winding down? 🌙";
  }
  String get _appBarSubtitle {
    final timeOfDay = TimeOfDay.now();
    if (timeOfDay.hour >= 3 && timeOfDay.hour < 12) {
      return "Let's make today productive.";
    } else if (timeOfDay.hour >= 12 && timeOfDay.hour <= 16) {
      return "You're doing great. Keep going!";
    } else if (timeOfDay.hour > 16 && timeOfDay.hour < 20) {
      return "A little progress goes a long way.";
    }
    return "Let's wrap up your day gently.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _appBarTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _appBarSubtitle,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Center(child: Text("home")),
    );
  }
}
