import 'package:hive/hive.dart';
import 'package:todo/database/models/todo_model.dart';

// Class to init HiveDb Box
// Provides Constant values
// A centralized Variable access for multiple classes
// And to avoid creating multiple HiveDb boxes


class DatabaseConstants {
  
  // A static variable of HiveDB Box to avoid multiple Box initialization
  static Box<TodoModel>? _todoHiveBox;
  final String _dbName = "todo_db";
  
  Box<TodoModel> getChatDatabase() {
   
   // Checking if HiveBox is initialized or not.
   // If _todoHiveBox is null, _todoHiveBox will be initialized with a new HiveDb Box 
   _todoHiveBox ??= Hive.box<TodoModel>(dbName);
    return _todoHiveBox!;
  }

  String get dbName => _dbName;
  
}