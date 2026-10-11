import 'package:flutter/material.dart';
import 'package:shiuli/theme.dart';

class NewTodoPage extends StatelessWidget {
  const NewTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Todo", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      ),
      body: NewTodoPageBody(),
    );
  }
}

class NewTodoPageBody extends StatefulWidget {
  const NewTodoPageBody({super.key});

  @override
  State<NewTodoPageBody> createState() => _NewTodoPageBodyState();
}

class _NewTodoPageBodyState extends State<NewTodoPageBody> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
            child: Text(
              "Todo Title",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppTheme.lightTheme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            child: TextField(
              decoration: InputDecoration(hintText: "What needs to be done?"),
              controller: titleController,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
            child: Text(
              "Description",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppTheme.lightTheme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            child: TextField(
              decoration: InputDecoration(hintText: "Add more details..."),
              controller: descriptionController,
            ),
          ),
        ],
      ),
    );
  }
}
