import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<TodoProvider>(context, listen: false).addNewTodoItem(
                TodoModel(title: "My second Task", duration: 1000));
          },
          child: const Icon(
            Icons.add_task,
            color: Colors.amber,
          ),
        ),
        body: getHomeBody(context),
      ),
    );
  }

  Widget getHomeBody(BuildContext context) {
    if (context.watch<TodoProvider>().todoList.isNotEmpty) {
      return const ListTodoView();
    } else {
      return Text(
        "No Data Available",
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.black),
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
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white54,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                child: Text(todoProvider.todoList[index].title),
              );
            },
            separatorBuilder: (context, index) {
              return Container(height: 8);
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
