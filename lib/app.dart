import 'package:flutter/material.dart';
import 'package:todo_riverpod/src/app_theme.dart';
import 'package:todo_riverpod/src/routes.dart';
import 'package:todo_riverpod/src/ui/screens/my_homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Todo',
      theme: AppTheme.light(),
      initialRoute: Routes.home,
      routes: Routes.all,
    );
  }
}
