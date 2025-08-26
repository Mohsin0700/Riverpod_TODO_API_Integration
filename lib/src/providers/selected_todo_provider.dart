// File: lib/src/providers/selected_todo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';

/// Holds the currently selected Todo (useful for global selection, bottom-sheets,
/// or when you prefer global state instead of passing route arguments).
///
/// Usage:
///  - Set: ref.read(selectedTodoProvider.notifier).state = someTodo;
///  - Read: final todo = ref.watch(selectedTodoProvider);

final selectedTodoProvider = StateProvider<Todo?>((ref) => null);
