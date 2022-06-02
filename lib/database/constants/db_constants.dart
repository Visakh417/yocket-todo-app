import 'package:hive/hive.dart';
import 'package:todo/database/models/todo_model.dart';

class DatabaseConstants {
  
  static Box<TodoModel>? _todoHiveBox;
  final String _dbName = "todo_db";
  
  Box<TodoModel> getChatDatabase() {
   
   _todoHiveBox ??= Hive.box<TodoModel>(dbName);
    return _todoHiveBox!;
  }

  String get dbName => _dbName;
  
}