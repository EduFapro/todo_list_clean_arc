import 'package:hive/hive.dart';

import '../../domain/entities/task.dart';

class TaskLocalDataSource {
  static const String tasksBoxName = "tasks";
  static final TaskLocalDataSource _singleton = TaskLocalDataSource._internal();

  // Private constructor
  TaskLocalDataSource._internal();

  // Factory constructor to return the same instance
  factory TaskLocalDataSource() => _singleton;
  Future<Box<Task>> openTasksBox() async {
    return await Hive.openBox<Task>(tasksBoxName);
  }

  Future<List<Task>> getTasks() async {
    final box = await openTasksBox();
    return box.values.toList();
  }

  Future<void> addTask(Task task) async {
    final box = await openTasksBox();
    await box.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    final box = await openTasksBox();
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await openTasksBox();
    await box.delete(id);
  }
}
