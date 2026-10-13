import 'package:flutter/material.dart';
import 'package:shiuli/constants.dart';
import 'package:shiuli/db.dart';
import 'package:shiuli/models/todo.dart';
import 'package:shiuli/notifiers.dart';
import 'package:shiuli/theme.dart';

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
            Text(_appBarTitle, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_appBarSubtitle, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: Center(child: TodaysTasks()),
    );
  }
}

class TodaysTasks extends StatefulWidget {
  const TodaysTasks({super.key});

  @override
  State<TodaysTasks> createState() => _TodaysTasksState();
}

class _TodaysTasksState extends State<TodaysTasks> {
  String _selected = "All";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(12.0, 10.0, 12.0, 8),
          child: Text(
            "Today's Tasks",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppTheme.lightTheme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["All", "Pending", "Completed"].map((cat) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ChoiceChip(
                  label: Text(
                    cat,
                    style: TextStyle(
                      fontSize: 17,
                      color: _selected == cat
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                  showCheckmark: false,
                  selected: _selected == cat,
                  onSelected: (value) {
                    setState(() {
                      _selected = cat;
                    });
                  },
                  selectedColor: AppColors.primary,
                  checkmarkColor: Colors.white,
                  side: BorderSide(color: AppColors.border),
                ),
              );
            }).toList(),
          ),
        ),
        switch (_selected) {
          "All" => TodaysAllTodos(),
          "Pending" => Text("Pending"),
          _ => Text("Completed"),
        },
      ],
    );
  }
}

class TodaysAllTodos extends StatefulWidget {
  const TodaysAllTodos({super.key});

  @override
  State<TodaysAllTodos> createState() => _TodaysAllTodosState();
}

class _TodaysAllTodosState extends State<TodaysAllTodos> {
  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    todaysTodosNotifier.value = await AppDatabase.instance.fetchTodaysTodos();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      return ValueListenableBuilder(
        valueListenable: todaysTodosNotifier,
        builder: (context, value, child) {
          return Column(
            children: value.map((todo) {
              return TodoItem(todo: todo!);
            }).toList(),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
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
    return CheckboxListTile(
      title: Text(widget.todo.title),
      value: widget.todo.completed,
      onChanged: (value) async {
        setState(() {
          AppDatabase.instance.setCompletedStatus(widget.todo.id!, value!);
        });
        todaysTodosNotifier.value = await AppDatabase.instance
            .fetchTodaysTodos();
      },
    );
  }
}
