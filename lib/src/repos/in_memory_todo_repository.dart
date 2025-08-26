import 'package:todo_riverpod/src/repos/todo_repo.dart';

import '../models/todo.dart';

class InMemoryTodoRepository implements TodoRepository {
  final List<Todo> _store = [];

  @override
  Future<List<Todo>> loadTodos() async {
    // simulate latency
    await Future.delayed(Duration(milliseconds: 100));
    return List.unmodifiable(_store);
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    _store.add(todo);
    await Future.delayed(Duration(milliseconds: 50));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final idx = _store.indexWhere((t) => t.id == todo.id);
    if (idx != -1) _store[idx] = todo;
    await Future.delayed(Duration(milliseconds: 50));
  }

  @override
  Future<void> deleteTodo(String id) async {
    _store.removeWhere((t) => t.id == id);
    await Future.delayed(Duration(milliseconds: 50));
  }
}
