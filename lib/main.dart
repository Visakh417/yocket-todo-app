import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/ui/home_screen.dart';

import 'database/controllers/database_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DbContoller().init();
  } catch (e) {
    DbContoller().deleteDbAndRecreateOne();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>(
            create: (_) => TodoProvider()..init()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yocket ToDo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: const TextTheme(
            headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
