import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shiuli/constants.dart';
import 'package:shiuli/models/todo.dart';
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
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TodoCategory _selectedCategory = TodoCategory.work;
  TodoPriority _selectedPriority = TodoPriority.medium;
  String get _date {
    List<String> months = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}";
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
                    child: Text(
                      "Date",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppTheme.lightTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {
                      _showDatePicker();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_outlined, size: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _date,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 3),
                    child: Text(
                      "Time",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppTheme.lightTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {
                      _showTimePicker();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.watch_later_outlined, size: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedTime.format(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(10.0, 10.0, 10.0, 8),
            child: Text(
              "Category",
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
            child: Text(
              "Priority",
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
