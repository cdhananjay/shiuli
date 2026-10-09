import 'package:flutter/material.dart';
import 'package:shiuli/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shiuli',
      theme: AppTheme.lightTheme,
      home: const MainHome(),
    );
  }
}

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("hai 🌸"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('home page'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'New Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
