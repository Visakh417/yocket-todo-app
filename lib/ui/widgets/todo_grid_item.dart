import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/utils/time_util.dart';

class TodoGridItem extends StatelessWidget {
  final TodoModel todoItem;
  const TodoGridItem(this.todoItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<TodoProvider>(context, listen: false)
          .toggleTodoPauseResume(todoItem.title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_getStatus(todoItem),style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.blue
                ),),
            const SizedBox(height: 8,),
            Text(
              todoItem.title,
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 2,
            ),
            const SizedBox(height: 8,),
            if (todoItem.description != null &&
                todoItem.description!.isNotEmpty)
              Text(
                todoItem.description ?? "",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black54
                ),
                maxLines: 2,
                
              ),
            const SizedBox(height: 8,),
            Text(TimeUtil.getTimeRemaining(
                todoItem.duration, todoItem.passedTime)),
            if (todoItem.status != "Done")
              Icon(todoItem.isPaused ? Icons.play_arrow : Icons.pause)
            else
              const SizedBox(height: 8,),
            const Spacer(),
            InkWell(
                onTap: () => Provider.of<TodoProvider>(context, listen: false)
                    .removeTodoTask(todoItem.title),
                child: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  String _getStatus(TodoModel todo) {
    if (todoItem.passedTime >= todoItem.duration) return "Done";

    if (todoItem.passedTime > 0) return "In-Process";

    return "TODO";
  }
}
