import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  late int duration;

  @HiveField(3)
  late int passedTime;

  @HiveField(4)
  String status = "TODO";

  @HiveField(5)
  bool isPaused = true;

  TodoModel({
    required this.title,
    required this.duration,
    this.description = "",
    this.isPaused = true,
    this.passedTime = 0,
    this.status = "TODO"
  });
}