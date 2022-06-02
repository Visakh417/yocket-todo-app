import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/models/todo_model.dart';

import '../constants/db_constants.dart';

class DbContoller {
  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    if (!Hive.isBoxOpen(DatabaseConstants().dbName)) {
      await Hive.openBox<TodoModel>(DatabaseConstants().dbName);
    }
  }

  Future<void> deleteDbAndRecreateOne() async {
    Hive.deleteBoxFromDisk(DatabaseConstants().dbName);
    await init();
  }

  void createTodo(TodoModel todo) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();

    todoBox.put(todo.title, todo);
  }

  void deleteTodoItem(String title) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();

    todoBox.delete(title);
  }

  void toggleTaskPauseResume(String title) {
    final Box<TodoModel> todoBox = DatabaseConstants().getChatDatabase();
    TodoModel? todo = todoBox.get(title);

    if (todo == null) return;
    todo.isPaused = !todo.isPaused;
    todoBox.put(title, todo);
  }

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
