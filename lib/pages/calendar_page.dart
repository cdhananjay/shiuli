import 'package:flutter/material.dart';
import 'package:shiuli/constants.dart';
import 'package:shiuli/db.dart';
import 'package:shiuli/models/todo.dart';

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

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: false,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      tileColor: widget.todo.completed ? AppColors.leafGreen : AppColors.card,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
        child: Text(
          widget.todo.title,
          style: TextStyle(
            decorationThickness: 3,
            decoration: widget.todo.completed
                ? TextDecoration.lineThrough
                : null,
            fontSize: 17,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Chip(
            avatar: Icon(Icons.circle, color: AppColors.primary),
            label: Text(widget.todo.category.name),
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            side: BorderSide(color: AppColors.border),
            visualDensity: VisualDensity(vertical: -3),
          ),
          Row(
            spacing: 5,
            children: [
              Icon(Icons.access_time_outlined, size: 15),
              Text(
                TimeOfDay.fromDateTime(widget.todo.dateTime).format(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
