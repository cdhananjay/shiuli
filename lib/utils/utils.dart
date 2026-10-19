import 'package:flutter/material.dart';

String get appBarTitle {
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

String get appBarSubtitle {
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
