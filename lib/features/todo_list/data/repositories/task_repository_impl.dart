import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ValueNotifier<List<Task>> _tasksNotifier =
      ValueNotifier<List<Task>>([]);

  @override
  Future<List<Task>> getTasks() async {
    return _tasksNotifier.value;
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = List<Task>.from(_tasksNotifier.value)..add(task);
    _tasksNotifier.value = tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks =
        _tasksNotifier.value.map((t) => t.id == task.id ? task : t).toList();
    _tasksNotifier.value = tasks;
  }
}
