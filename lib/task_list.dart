import 'package:flutter/material.dart';
import 'Tasks/CounterApp/counterApp.dart';
import 'Tasks/Stack/stack.dart';

class TaskItem {
  final String title;
  final Widget page;

  TaskItem({required this.title, required this.page});
}

final List<TaskItem> tasks = [
  TaskItem(title: 'Counter App', page: const CounterApp()),
  TaskItem(title: 'Stack', page: const StackDetails()),
];