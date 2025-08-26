import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/src/models/todo.dart';
import 'package:todo_riverpod/src/providers/todo_list_provider.dart';

enum TodoFilter { all, active, completed }

final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoListProvider);
  switch (filter) {
    case TodoFilter.active:
      return todos.where((t) => !t.completed).toList();
    case TodoFilter.completed:
      return todos.where((t) => t.completed).toList();
    case TodoFilter.all:
    default:
      return todos;
  }
});
