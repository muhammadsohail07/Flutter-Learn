import 'package:flutter/material.dart';
import 'package:flutter_series/Tasks/LocalStorage/servicetodolocalstorage.dart';
import 'package:flutter_series/Tasks/LocalStorage/modeltodolocalstorage.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

 final todoStorageService _storageService = todoStorageService();
  List<todo> _todos = [];
  bool _isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _storageService.loadTodo();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _todos.add(todo(title: text));
    });
    _controller.clear();
    _storageService.saveTodos(_todos);
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
    _storageService.saveTodos(_todos);
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    _storageService.saveTodos(_todos);
  }

  Future<void> _clearAll() async {
    await _storageService.clearAlltodo();
    setState(() {
      _todos.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App (SharedPreferences)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear All',
            onPressed: _todos.isEmpty
                ? null
                : () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Sab kuch delete karna hai?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _clearAll();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Delete All'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Naya task likho...',
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // ---- List ----
          Expanded(
            child: _todos.isEmpty
                ? const Center(
              child: Text(
                'Koi task nahi hai.\nUpar se add karo!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) => _toggleTodo(index),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todo.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTodo(index),
                    ),
                  ),
                );
              },
            ),
          ),

          // ---- Footer info ----
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: ${_todos.length}  |  Done: ${_todos.where((t) => t.isDone).length}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}