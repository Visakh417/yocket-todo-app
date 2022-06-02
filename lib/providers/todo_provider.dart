import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/constants/db_constants.dart';
import '../database/controllers/database_controller.dart';
import '../database/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  bool _isListView = false;
  bool _isSubscribedToDb = false;
  final Box<TodoModel> _todoBox = DatabaseConstants().getChatDatabase();
  List<TodoModel> _todoList = [];

  void init() {
    _callDbListener();
    _todoList = _todoBox.values.toList();
  }

  void _callDbListener() {
    if (_isSubscribedToDb) return;
    _isSubscribedToDb = true;

    _todoBox.listenable().addListener(() {
      _todoList = _todoBox.values.toList();
      notifyListeners();
    });
  }

  void toggleView() {
    _isListView = !_isListView;
  }

  void addNewTodoItem(TodoModel todoItem) {
    DbContoller().createTodo(todoItem);
  }

  List<TodoModel> get todoList => _todoList;
  bool get isListView => _isListView;
}
