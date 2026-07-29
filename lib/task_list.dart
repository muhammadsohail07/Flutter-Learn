import 'package:flutter/material.dart';
import 'Tasks/CounterApp/counterApp.dart';

class TaskItem {
  final String title;
  final Widget page;

  TaskItem({required this.title, required this.page});
}

final List<TaskItem> tasks = [
  TaskItem(title: 'Counter App', page: const CounterApp()),
];