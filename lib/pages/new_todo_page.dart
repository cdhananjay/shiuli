import 'package:flutter/material.dart';
import 'package:shiuli/utils/constants.dart';
import 'package:shiuli/data/db.dart';
import 'package:shiuli/models/todo.dart';
import 'package:shiuli/data/notifiers.dart';
import 'package:shiuli/utils/theme.dart';
import 'package:shiuli/widgets/date_picker_button.dart';
import 'package:shiuli/widgets/header_text.dart';
import 'package:shiuli/widgets/save_todo_button.dart';
import 'package:shiuli/widgets/time_picker_button.dart';

class NewTodoPage extends StatelessWidget {
  const NewTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Todo", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      ),
      body: SafeArea(child: NewTodoPageBody()),
    );
  }
}

class NewTodoPageBody extends StatefulWidget {
  const NewTodoPageBody({super.key});

  @override
  State<NewTodoPageBody> createState() => _NewTodoPageBodyState();
}

class _NewTodoPageBodyState extends State<NewTodoPageBody> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _title = "";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TodoCategory _selectedCategory = TodoCategory.work;
  TodoPriority _selectedPriority = TodoPriority.medium;

  String get _date {
    return "${months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
                      child: HeaderText("Todo Title*"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "What needs to be done?",
                        ),
                        controller: _titleController,
                        onChanged: (value) {
                          setState(() {
                            _title = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
                      child: HeaderText("Description"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Add more details...",
                        ),
                        controller: _descriptionController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(
                                10.0,
                                10.0,
                                10.0,
                                3,
                              ),
                              child: HeaderText("Date"),
                            ),
                            DatePickerButton(
                              date: _date,
                              onPressed: () async {
                                _showDatePicker();
                              },
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(
                                10.0,
                                10.0,
                                10.0,
                                3,
                              ),
                              child: HeaderText("Time"),
                            ),
                            TimePickerButton(
                              selectedTime: _selectedTime,
                              onPressed: () async {
                                _showTimePicker();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 8),
                      child: HeaderText("Category"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            [
                              TodoCategory.learning,
                              TodoCategory.work,
                              TodoCategory.personal,
                            ].map((cat) {
                              return ChoiceChip(
                                label: Text(
                                  cat.name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: _selectedCategory == cat
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                selected: _selectedCategory == cat,
                                onSelected: (value) {
                                  setState(() {
                                    _selectedCategory = cat;
                                  });
                                },
                                selectedColor: AppColors.primary,
                                checkmarkColor: Colors.white,
                                side: BorderSide(color: AppColors.border),
                              );
                            }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 8),
                      child: HeaderText("Priority"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            [
                              TodoPriority.low,
                              TodoPriority.medium,
                              TodoPriority.high,
                            ].map((prio) {
                              return ChoiceChip(
                                label: Text(
                                  prio.name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: _selectedPriority == prio
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                selected: _selectedPriority == prio,
                                onSelected: (value) {
                                  setState(() {
                                    _selectedPriority = prio;
                                  });
                                },
                                selectedColor: AppColors.primary,
                                checkmarkColor: Colors.white,
                                side: BorderSide(color: AppColors.border),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: SaveTodoButton(title: _title, saveTodoFn: _saveTodo),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveTodo() async {
    AppDatabase.instance.createTodo(
      Todo(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory,
        priority: _selectedPriority,
        dateTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        completed: false,
      ),
    );
    todaysTodosNotifier.value = await AppDatabase.instance.getTodosByDate(
      DateTime.now(),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      initialDate: _selectedDate,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
