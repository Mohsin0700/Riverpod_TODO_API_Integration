import '../models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> loadTodos();
  Future<void> saveTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
