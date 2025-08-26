import 'package:flutter/material.dart';
import '../../models/todo.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> items;
  const TodoList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No todos yet'));
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, idx) => TodoItem(item: items[idx]),
    );
  }
}
