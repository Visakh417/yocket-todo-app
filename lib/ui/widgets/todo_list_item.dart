import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/utils/time_util.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todoItem;
  const TodoListItem(this.todoItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<TodoProvider>(context, listen: false)
          .toggleTodoPauseResume(todoItem.title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getStatus(todoItem), style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.blue
                ),),
            const SizedBox(height: 8,),
            Text(
              todoItem.title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.white
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 8,),
            if (todoItem.description != null &&
                todoItem.description!.isNotEmpty)
              Text(
                todoItem.description ?? "",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white54
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Text(TimeUtil.getTimeRemaining(
                    todoItem.duration, todoItem.passedTime), style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.amber
                )),
                if (todoItem.status != "Done")
                  Icon(todoItem.isPaused ? Icons.play_arrow : Icons.pause, color: Colors.white,),
                const Spacer(),
                InkWell(
                    onTap: () =>
                        Provider.of<TodoProvider>(context, listen: false)
                            .removeTodoTask(todoItem.title),
                    child: const Icon(Icons.delete, color: Colors.red,))
              ],
            )
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
