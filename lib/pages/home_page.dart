import 'package:flutter/material.dart';
import 'package:shiuli/utils/constants.dart';
import 'package:shiuli/data/db.dart';
import 'package:shiuli/models/todo.dart';
import 'package:shiuli/data/notifiers.dart';
import 'package:shiuli/utils/theme.dart';
import 'package:shiuli/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appBarTitle, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(appBarSubtitle, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [DailyProgress(), TodaysTasks()]),
      ),
    );
  }
}

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ValueListenableBuilder(
        valueListenable: todaysTodosNotifier,
        builder: (context, value, child) {
          return Card(
            elevation: 0,
            color: AppColors.leafGreen,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your daily progress",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    value.isEmpty
                        ? "No tasks for today"
                        : "${value.where((todo) {
                            return todo.completed;
                          }).length} of ${value.length} tasks completed",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: LinearProgressIndicator(
                      value: value.isEmpty
                          ? 1
                          : value.where((todo) {
                                  return todo.completed;
                                }).length /
                                value.length,
                      backgroundColor: AppColors.card,
                      minHeight: 15,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
          "Pending" => TodaysTasksFilteredByCompletedStatus(
            completedStatus: false,
          ),
          _ => TodaysTasksFilteredByCompletedStatus(completedStatus: true),
        },
      ],
    );
  }
}

class TodaysTasksFilteredByCompletedStatus extends StatelessWidget {
  const TodaysTasksFilteredByCompletedStatus({
    super.key,
    required this.completedStatus,
  });
  final bool completedStatus;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todaysTodosNotifier,
      builder: (context, value, child) {
        return Column(
          children: value
              .where((todo) {
                return todo.completed == completedStatus;
              })
              .map((todo) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                  child: TodoItem(todo: todo),
                );
              })
              .toList(),
        );
      },
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
    todaysTodosNotifier.value = await AppDatabase.instance.getTodosByDate(
      DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      return ValueListenableBuilder(
        valueListenable: todaysTodosNotifier,
        builder: (context, value, child) {
          return Column(
            children: value.map((todo) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                child: TodoItem(todo: todo),
              );
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
      controlAffinity: ListTileControlAffinity.leading,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      tileColor: AppColors.card,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
        child: Text(
          widget.todo.title,
          style: TextStyle(
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

      selectedTileColor: Colors.black,
      value: widget.todo.completed,
      onChanged: (value) async {
        setState(() {
          AppDatabase.instance.setCompletedStatus(widget.todo.id!, value!);
        });
        todaysTodosNotifier.value = await AppDatabase.instance.getTodosByDate(
          DateTime.now(),
        );
      },
    );
  }
}
