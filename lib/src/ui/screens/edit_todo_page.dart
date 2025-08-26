import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/todo.dart';
import '../../providers/todo_list_provider.dart';

class EditTodoPage extends ConsumerStatefulWidget {
  const EditTodoPage({super.key});

  @override
  ConsumerState<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends ConsumerState<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  Todo? editing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Expecting Todo passed via arguments
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Todo) {
      editing = args;
      _titleCtrl = TextEditingController(text: editing!.title);
      _descCtrl = TextEditingController(text: editing!.description);
    } else {
      // fallback
      _titleCtrl = TextEditingController();
      _descCtrl = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    if (editing == null) return;
    if (!_formKey.currentState!.validate()) return;
    final updated = editing!.copyWith(
      title: _titleCtrl.text,
      description: _descCtrl.text,
    );
    await ref.read(todoListProvider.notifier).update(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                minLines: 1,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _save, child: const Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
