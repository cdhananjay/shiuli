enum TodoCategory { work, learning, personal }

enum TodoPriority { low, medium, high }

extension TodoCategoryExtension on TodoCategory {
  String get name {
    switch (this) {
      case TodoCategory.work:
        return "Work";
      case TodoCategory.learning:
        return "Learning";
      case TodoCategory.personal:
        return "Personal";
    }
  }

  static TodoCategory fromString(String value) {
    switch (value) {
      case "Work":
        return TodoCategory.work;
      case "Learning":
        return TodoCategory.learning;
      case "Personal":
        return TodoCategory.personal;
      default:
        throw ArgumentError("Invalid TodoCategory");
    }
  }
}

extension TodoPriorityExtension on TodoPriority {
  String get name {
    switch (this) {
      case TodoPriority.low:
        return "Low";
      case TodoPriority.medium:
        return "Medium";
      case TodoPriority.high:
        return "High";
    }
  }

  static TodoPriority fromString(String value) {
    switch (value) {
      case "Low":
        return TodoPriority.low;
      case "Medium":
        return TodoPriority.medium;
      case "High":
        return TodoPriority.high;
      default:
        throw ArgumentError("Invalid TodoPriority");
    }
  }
}

const String tableName = "todos";

const String idField = "_id";
const String titleField = "title";
const String descriptionField = "description";
const String dateTimeField = "date_time";
const String categoryField = "category";
const String priorityField = "priority";
const String completedField = "completed";

const List<String> todoColumns = [
  idField,
  titleField,
  descriptionField,
  dateTimeField,
  categoryField,
  priorityField,
  completedField,
];

const String boolType = "BOOLEAN NOT NULL";
const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const String textTypeNullable = "TEXT";
const String textType = "TEXT NOT NULL";

class Todo {
  Todo({
    this.id,
    required this.title,
    this.description,
    required this.dateTime,
    required this.category,
    required this.priority,
    required this.completed,
  });
  final int? id;
  final String title;
  final String? description;
  final DateTime dateTime;
  final TodoCategory category;
  final TodoPriority priority;
  final bool completed;

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json[idField] as int,
      title: json[titleField] as String,
      description: json[descriptionField] as String,
      dateTime: DateTime.parse(json[dateTimeField] as String),
      category: TodoCategoryExtension.fromString(json[categoryField] as String),
      priority: TodoPriorityExtension.fromString(json[priorityField] as String),
      completed: json[completedField] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idField: id,
      titleField: title,
      descriptionField: description,
      dateTimeField: dateTime.toIso8601String(),
      categoryField: category.name,
      priorityField: priority.name,
      completedField: completed ? 1 : 0,
    };
  }

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
    TodoCategory? category,
    TodoPriority? priority,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
    );
  }
}
