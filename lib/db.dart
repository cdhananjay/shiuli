import 'package:path/path.dart';
import 'package:shiuli/models/todo.dart';
import 'package:sqflite/sqflite.dart';

const String fileName = "todos.db";

class AppDatabase {
  AppDatabase._init();

  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB(fileName);
    return _database!;
  }

  Future<Database> _initializeDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      $idField $idType,
      $titleField $textType,
      $descriptionField $textType,
      $dateTimeField $textType,
      $categoryField $textType,
      $priorityField $textType,
      $completedField $boolType
    )
    ''');
  }

  Future<Todo> createTodo(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableName, todo.toJson());
    return todo.copyWith(id: id);
  }

  Future<List<Todo?>> fetchTodos() async {
    final db = await instance.database;
    final result = await db.query(tableName, orderBy: "$dateTimeField DESC");
    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<List<Todo>> fetchTodaysTodos() async {
    final today = DateTime.now();
    final tomorrow = today.add(Duration(days: 1));
    final db = await instance.database;
    final result = await db.query(
      tableName,
      where:
          "$dateTimeField > '${DateTime(today.year, today.month, today.day).toIso8601String()}' AND $dateTimeField < '${DateTime(tomorrow.year, tomorrow.month, tomorrow.day).toIso8601String()}'",
      orderBy: dateTimeField,
    );
    return result.map((json) => Todo.fromJson(json)).toList();
  }

  void setCompletedStatus(int id, bool status) async {
    final db = await instance.database;
    await db.update(tableName, {
      completedField: status ? 1 : 0,
    }, where: "$idField = '$id'");
  }

  Future<void> close() async {
    final db = await instance.database;
    return db.close();
  }
}
