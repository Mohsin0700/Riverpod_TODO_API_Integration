import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/todo.dart';
import '../../providers/todo_list_provider.dart';

class TodoItem extends ConsumerWidget {
  final Todo item;
  const TodoItem({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(item.id),
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => ref.read(todoListProvider.notifier).remove(item.id),
      child: ListTile(
        leading: Checkbox(
          value: item.completed,
          onChanged: (_) => ref.read(todoListProvider.notifier).toggle(item.id),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            decoration: item.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: item.description != null && item.description!.isNotEmpty
            ? Text(item.description!)
            : null,
        onTap: () => Navigator.pushNamed(context, '/edit', arguments: item),
      ),
    );
  }
}
