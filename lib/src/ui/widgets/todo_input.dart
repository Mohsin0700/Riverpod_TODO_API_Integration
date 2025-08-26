import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/todo.dart';
import '../../providers/todo_list_provider.dart';

class TodoInput extends ConsumerStatefulWidget {
  const TodoInput({super.key});

  @override
  ConsumerState<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends ConsumerState<TodoInput> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final todo = Todo(id: id, title: text);
    await ref.read(todoListProvider.notifier).add(todo);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ctrl,
            decoration: const InputDecoration(hintText: 'Add a todo...'),
            onSubmitted: (_) => _submit(),
          ),
        ),
        IconButton(onPressed: _submit, icon: const Icon(Icons.send)),
      ],
    );
  }
}

// File: lib/src/utils/validators.dart
String? nonEmpty(String? v) =>
    (v == null || v.trim().isEmpty) ? 'Required' : null;
