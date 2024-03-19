import 'package:flutter/material.dart';
import 'package:untitled/features/todo_list/domain/usecases/delete_task.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';

class TodoListController {
  final GetTasks getTodoList;
  final AddTask addTodo;
  final UpdateTask updateTodo;
  final DeleteTask deleteTodo;

  ValueNotifier<List<Task>> tasksNotifier = ValueNotifier([]);

  TodoListController({
    required this.getTodoList,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
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

  Future<void> deleteTask(Task task) async {
    await deleteTodo(task.id.toString());
    loadTasks();
  }

  Future<void> createAndAddTask(String title, {bool isCompleted = false}) async {
    final newTask = Task(id: UniqueKey().toString(), title: title, isCompleted: isCompleted);
    await addTask(newTask);
    await loadTasks();
  }

}
