import 'package:flutter/material.dart';
import 'package:shiuli/constants.dart';
import 'package:shiuli/db.dart';
import 'package:shiuli/models/todo.dart';
import 'package:shiuli/pages/home_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Calendar", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(child: Body()),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _selectedDate = DateTime.now();
  List<Todo> _todos = [];
  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() async {
    final todos = await AppDatabase.instance.getTodosByDate(_selectedDate);
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.card,
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            onDateChanged: (value) {
              setState(() {
                _selectedDate = value;
                _fetchTodos();
              });
            },
          ),
        ),
        TodosForDay(todos: _todos),
      ],
    );
  }
}

class TodosForDay extends StatelessWidget {
  final List<Todo> todos;
  const TodosForDay({required this.todos, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Text(
              "Tasks for this day",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            spacing: 8,
            children: todos.map((todo) {
              return TodoItem(todo: todo);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
