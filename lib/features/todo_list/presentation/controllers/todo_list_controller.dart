import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';

class TodoListController {
  final GetTasks getTodoList;
  final AddTask addTodo;
  final UpdateTask updateTodo;

  ValueNotifier<List<Task>> tasksNotifier = ValueNotifier([]);

  TodoListController({
    required this.getTodoList,
    required this.addTodo,
    required this.updateTodo,
  });

  Future<void> loadTasks() async {
    final tasksList = await getTodoList();
    tasksNotifier.value = tasksList;
  }

  Future<void> addTask(Task task) async {
    await addTodo(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await updateTodo(task);
    loadTasks();
  }
}
