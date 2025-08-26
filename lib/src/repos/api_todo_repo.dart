import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import 'todo_repo.dart';

class ApiTodoRepository implements TodoRepository {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiTodoRepository({
    required this.baseUrl,
    Map<String, String>? defaultHeaders,
  }) : defaultHeaders = defaultHeaders ?? {'Content-Type': 'application/json'};

  Uri _uri(String path) => Uri.parse(baseUrl + path);

  @override
  Future<List<Todo>> loadTodos() async {
    final res = await http.get(_uri('/todos'), headers: defaultHeaders);
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as List;
      return body.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load todos: ${res.statusCode} ${res.body}');
    }
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final payload = jsonEncode({
      'title': todo.title,
      'description': todo.description,
      'completed': todo.completed,
      'createdAt': todo.createdAt.toUtc().toIso8601String(),
    });
    final res = await http.post(
      _uri('/todos'),
      headers: defaultHeaders,
      body: payload,
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Failed to save todo: ${res.statusCode} ${res.body}');
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final payload = jsonEncode(todo.toJson());
    final res = await http.put(
      _uri('/todos/${todo.id}'),
      headers: defaultHeaders,
      body: payload,
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to update todo: ${res.statusCode} ${res.body}');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final res = await http.delete(_uri('/todos/$id'), headers: defaultHeaders);
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Failed to delete todo: ${res.statusCode} ${res.body}');
    }
  }
}
