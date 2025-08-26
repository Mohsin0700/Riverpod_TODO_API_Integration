import 'package:flutter/material.dart';
import 'package:todo_riverpod/src/ui/screens/add_todo_page.dart';
import 'package:todo_riverpod/src/ui/screens/edit_todo_page.dart';
import 'package:todo_riverpod/src/ui/screens/my_homepage.dart';

class Routes {
  static const home = '/';
  static const add = '/add';
  static const edit = '/edit';

  static Map<String, WidgetBuilder> get all => {
    home: (c) => HomePage(),
    add: (c) => const AddTodoPage(),
    edit: (c) => const EditTodoPage(),
  };
}
