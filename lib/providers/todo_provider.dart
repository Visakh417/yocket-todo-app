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
    _todoList = _todoBox.values.toList();
    _callDbListener();
  }

  void _callDbListener() {
    if (_isSubscribedToDb) return;
    _isSubscribedToDb = true;

    _todoBox.listenable().addListener(() {
      _todoList = _todoBox.values.toList();
      notifyListeners();
    });

    _runTodoAnalysisProcess();
  }

  void toggleView() {
    _isListView = !_isListView;
  }

  void toggleTodoPauseResume(String title) {
    DbContoller().toggleTaskPauseResume(title);
  }

  void removeTodoTask(String title) {
    DbContoller().deleteTodoItem(title);
  }

  Future<void>? updateProcessTime(String title, int passedtime) async {
    DbContoller().updateToDoPassedTime(title, passedtime);
  }

  // ignore: prefer_final_fields
  bool _canAnalysisRun = true;
  Future<void> _runTodoAnalysisProcess() async {
    do {
      await Future.delayed(const Duration(seconds: 1));
      for (TodoModel todoItem in todoList) {
        if (!todoItem.isPaused && todoItem.status != 'Done') {
          updateProcessTime(todoItem.title, todoItem.passedTime + 1);
        }
      }
    } while (_canAnalysisRun);
  }

  void addNewTodoItem(TodoModel todoItem) {
    DbContoller().createTodo(todoItem);
  }

  List<TodoModel> get todoList => _todoList;
  bool get isListView => _isListView;
}
