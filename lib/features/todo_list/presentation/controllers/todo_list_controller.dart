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
  ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  TodoListController({
    required this.getTodoList,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  });

  Future<void> loadTasks() async {
    try {
      final tasksList = await getTodoList();
      tasksNotifier.value = tasksList;
      errorNotifier.value = null;

    } catch (e) {
      print(e);
      errorNotifier.value = "Não foi possível carregar as Tasks.";
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await addTodo(task);
      loadTasks();
    } on Exception catch (e) {
      print(e);
      errorNotifier.value = "Não foi possível adicionar a Task.";
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await updateTodo(task);
      loadTasks();
    } on Exception catch (e) {
      print(e);
      errorNotifier.value = "Não foi possível atualizar atualizar Task.";
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await deleteTodo(task.id.toString());
      loadTasks();
    } on Exception catch (e) {
      print(e);
      errorNotifier.value = "Não foi possível deletar a Task.";
    }
  }

  Future<void> createAndAddTask(String title, {bool isCompleted = false}) async {
    final newTask = Task(id: UniqueKey().toString(), title: title, isCompleted: isCompleted);
    await addTask(newTask);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );

    await updateTask(updatedTask);
  }

}
