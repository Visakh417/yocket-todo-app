import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/ui/widgets/add_todo_popup.dart';
import 'package:todo/ui/widgets/todo_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: Text(
              "Yocket ToDo",
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              InkWell(
                onTap: () => Provider.of<TodoProvider>(context, listen: false)
                    .toggleView(),
                child: Icon(context.watch<TodoProvider>().isListView
                    ? Icons.list
                    : Icons.grid_3x3),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Builder(builder: (builderContext) {
          return FloatingActionButton(
            onPressed: () async {
              TodoModel? newTodoItem = await showDialog<TodoModel>(
                  context: builderContext,
                  useSafeArea: true,
                  builder: (builderContext) {
                    return const AlertDialog(
                        insetPadding: EdgeInsets.all(0),
                        titlePadding: EdgeInsets.all(0),
                        buttonPadding: EdgeInsets.all(0),
                        actionsPadding: EdgeInsets.all(0),
                        contentPadding: EdgeInsets.all(0),
                        content: AddTodoPopupWidget());
                  });
              if (newTodoItem != null) {
                Provider.of<TodoProvider>(context, listen: false)
                    .addNewTodoItem(newTodoItem);
              }
            },
            child: const Icon(
              Icons.add_task,
              color: Colors.amber,
            ),
          );
        }),
        body: getHomeBody(context),
      ),
    );
  }

  Widget getHomeBody(BuildContext context) {
    if (context.watch<TodoProvider>().todoList.isNotEmpty) {
      return const ListTodoView();
    } else {
      return Center(
        child: Text(
          "No ToDos Created",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.black),
        ),
      );
    }
    // if (context.watch<TodoProvider>().isListView) {
    //   return const ListTodoView();
    // } else {
    //   return const GridTodoView();
    // }
  }
}

class ListTodoView extends StatelessWidget {
  const ListTodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TodoListItem(todoProvider.todoList[index]));
            },
            separatorBuilder: (context, index) {
              return Container(height: 16);
            },
            itemCount: todoProvider.todoList.length);
      },
    );
  }
}

class GridTodoView extends StatelessWidget {
  const GridTodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
