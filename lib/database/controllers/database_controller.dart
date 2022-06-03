import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/models/todo_model.dart';

import '../constants/db_constants.dart';

class DbContoller {

  // init() will initialize the HiveDb and Register all the AdapterClasses
  Future<void> init() async {
    await Hive.initFlutter();

    // Registering TodoModelAdapter, if it is not registered already
    if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    // Opening HiveBox after checking if it is opened or not.
    // Warning: Opening multiple HiveBox will damage the HiveDb
    if (!Hive.isBoxOpen(DatabaseConstants().dbName)) {
      await Hive.openBox<TodoModel>(DatabaseConstants().dbName);
    }
  }

  // To Recreate a new HiveDb, need to delete old Db
  // deleteDbAndRecreateOne() will Delete the old Database and Recreate a new Database
  // By Recreating all the Data will be removed from Db
  Future<void> deleteDbAndRecreateOne() async {
    Hive.deleteBoxFromDisk(DatabaseConstants().dbName);
    await init();
  }

  // Adding a new task in Database
  void createTodo(TodoModel todo) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();

    // Assuming task title will be unique and putting it as Item Identifier
    todoBox.put(todo.title, todo);
  }

  // Deleting a task from Database by passing title of the Task
  void deleteTodoItem(String title) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();

    todoBox.delete(title);
  }


  // Toggling a task pause and resume
  void toggleTaskPauseResume(String title) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();
    TodoModel? todo = todoBox.get(title);

    if (todo == null) return;
    todo.isPaused = !todo.isPaused;
    todoBox.put(title, todo);
  }


  // Updating how much time the task took so far
  void updateToDoPassedTime(String title, int passedtime) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();
    TodoModel? todo = todoBox.get(title);

    if (todo == null) return;
    todo.passedTime = passedtime;

    if (todo.passedTime >= todo.duration) {
      todo.status = "Done";
    }

    todoBox.put(title, todo);
  }
}
