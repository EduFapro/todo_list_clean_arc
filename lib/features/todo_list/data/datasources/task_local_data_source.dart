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
    try {
      // throw Exception("Failed to open tasks box.");
      return await Hive.openBox<TaskModel>(tasksBoxName);
    } catch (e) {
      print("Failed to open tasks box: $e");
      throw Exception("Failed to open tasks box.");
    }
  }



  Future<List<TaskModel>> getTasks() async {
    try {
      final box = await openTasksBox();
      print(box);
      print("aff");
      return box.values.toList();
    } on Exception catch (e) {
      print("Failed to fetch tasks $e");
      rethrow;
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      final box = await openTasksBox();
      await box.put(task.id, task);
    } catch (e) {
      print("Failed to add task: $e");
      rethrow;
    }
  }


  Future<void> updateTask(TaskModel task) async {
    try {
      final box = await openTasksBox();
      await box.put(task.id, task);
    } on Exception catch (e) {
      print("Failed to update task: $e");
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final box = await openTasksBox();
      await box.delete(id);
    } on Exception catch (e) {
      print("Failed to delete task: $e");
      rethrow;
    }
  }
}
