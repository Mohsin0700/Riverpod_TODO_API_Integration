import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/src/ui/widgets/todo_input.dart';
import '../../providers/todo_list_provider.dart';
import '../../providers/todo_filter_provider.dart';
import '../widgets/todo_list.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Todo')),
      body: Column(
        children: [
          Expanded(child: TodoList(items: todos)),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TodoInput()), // implement widget to add
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // toggle filter for demo
                    final cur = ref.read(todoFilterProvider);
                    ref
                        .read(todoFilterProvider.notifier)
                        .state = cur == TodoFilter.all
                        ? TodoFilter.active
                        : TodoFilter.all;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
