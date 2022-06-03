import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/constants/db_constants.dart';
import '../database/controllers/database_controller.dart';
import '../database/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {

  // _isListView is private flag for user view preferrence
  //default choice is ListView
  bool _isListView = true;

  // Flag for Db Listener calling.
  // Multiple listener calling will cause multiple callback subscription
  // It will affect the performance
  bool _isSubscribedToDb = false;

  // Init HiveBox
  final Box<TodoModel> _todoBox = DatabaseConstants().getChatDatabase();
  
  // Init _todoList as empty array
  List<TodoModel> _todoList = [];

  // init() will intialize the variables and call the dbSubscription 
  void init() {
    _todoList = _todoBox.values.toList();
    _callDbListener();
  }

  // Calling _callDbListener() for every update in HiveDb will be reflected
  void _callDbListener() {
    // Checking if the HiveDb subscription is already called or not
    if (_isSubscribedToDb) return;
    _isSubscribedToDb = true;

    // _todoBox will give a callback for every update in Db
    _todoBox.listenable().addListener(() {
      _todoList = _todoBox.values.toList();
      notifyListeners();
    });

    _runTodoAnalysisProcess();
  }

  // To change userpreference from ListView to GridView 
  // and vice verse
  void toggleView() {
    _isListView = !_isListView;
    notifyListeners();
  }

  // toggleTodoPauseResume will Toggle the Pause and Resume of a task.
  // In Database
  void toggleTodoPauseResume(String title) {
    DbContoller().toggleTaskPauseResume(title);
  }

  // To Delete a task from Database
  void removeTodoTask(String title) {
    DbContoller().deleteTodoItem(title);
  }

  // updateProcessTime will update the progress of a Task
  Future<void>? updateProcessTime(String title, int passedtime) async {
    DbContoller().updateToDoPassedTime(title, passedtime);
  }

  // To Add New Task in TodoDb
  void addNewTodoItem(TodoModel todoItem) {
    DbContoller().createTodo(todoItem);
  }

  // ignore: prefer_final_fields
  bool _canAnalysisRun = true;

  // A timer function with delay 1 second 
  // to update the progress in started todo tasks
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

  List<TodoModel> get todoList => _todoList;
  bool get isListView => _isListView;
}
