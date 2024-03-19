import 'package:hive/hive.dart';

import '../models/task_model.dart';


class TaskLocalDataSource {
  static const String tasksBoxName = "tasks";
  static final TaskLocalDataSource _singleton = TaskLocalDataSource._internal();

  // Private constructor
  TaskLocalDataSource._internal();

  // Factory constructor to return the same instance
  factory TaskLocalDataSource() => _singleton;
  Future<Box<TaskModel>> openTasksBox() async {
    return await Hive.openBox<TaskModel>(tasksBoxName);
  }

  Future<List<TaskModel>> getTasks() async {
    final box = await openTasksBox();
    return box.values.toList();
  }

  Future<void> addTask(TaskModel task) async {
    final box = await openTasksBox();
    await box.put(task.id, task);
  }

  Future<void> updateTask(TaskModel task) async {
    final box = await openTasksBox();
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await openTasksBox();
    await box.delete(id);
  }
}
