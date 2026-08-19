import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/ToDo App/todoemptystate.dart';
import 'package:flutter_series/Tasks/ToDo App/todomodel.dart';
import 'package:flutter_series/Tasks/ToDo App/todotitle.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.add(Todo(title: text));
    });
    _controller.clear();
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _editTodo(int index) {
    final editController = TextEditingController(text: _todos[index].title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newText = editController.text.trim();
              if (newText.isNotEmpty) {
                setState(() {
                  _todos[index].title = newText;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _todos.where((t) => t.isDone).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addTodo,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          if (_todos.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$completedCount of ${_todos.length} completed',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: _todos.isEmpty
                ? const EmptyState()
                : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoTile(
                  todo: todo,
                  onToggle: () => _toggleTodo(index),
                  onDelete: () => _deleteTodo(index),
                  onEdit: () => _editTodo(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}