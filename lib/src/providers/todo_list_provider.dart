import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/src/repos/in_memory_todo_repository.dart';
import 'package:todo_riverpod/src/repos/todo_repo.dart';
import '../models/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  final TodoRepository repository;
  TodoListNotifier(this.repository) : super([]);

  Future<void> load() async {
    final todos = await repository.loadTodos();
    state = todos;
  }

  Future<void> add(Todo todo) async {
    await repository.saveTodo(todo);
    state = [...state, todo];
  }

  Future<void> update(Todo todo) async {
    await repository.updateTodo(todo);
    state = [
      for (final t in state)
        if (t.id == todo.id) todo else t,
    ];
  }

  Future<void> toggle(String id) async {
    final item = state.firstWhere((t) => t.id == id);
    final updated = item.copyWith(completed: !item.completed);
    await update(updated);
  }

  Future<void> remove(String id) async {
    await repository.deleteTodo(id);
    state = state.where((t) => t.id != id).toList();
  }
}

// Provider for repository injection (simple)
final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return InMemoryTodoRepository(); // import it
});

// StateNotifierProvider
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((
  ref,
) {
  final repo = ref.read(todoRepositoryProvider);
  final notifier = TodoListNotifier(repo);
  notifier.load(); // initial load
  return notifier;
});
