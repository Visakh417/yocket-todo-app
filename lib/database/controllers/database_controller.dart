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
}
