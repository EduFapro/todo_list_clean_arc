import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  static final TaskRepositoryImpl _singleton = TaskRepositoryImpl._internal(TaskLocalDataSource());

  TaskRepositoryImpl._internal(this.localDataSource);

  factory TaskRepositoryImpl() => _singleton;

  @override
  Future<List<Task>> getTasks() async {
    try {
      final taskModels = await localDataSource.getTasks();
      return taskModels.map((model) => Task(
        id: model.id,
        title: model.title,
        isCompleted: model.isCompleted,
      )).toList();
    } catch (e) {
      print("Error fetching tasks: $e");
      // Optionally rethrow or handle the exception
      throw Exception("Error fetching tasks from local data source");
    }
  }

  @override
  Future<void> addTask(Task task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
      );
      await localDataSource.addTask(taskModel);
    } catch (e) {
      print("Error adding task: $e");
      // Optionally rethrow or handle the exception
      throw Exception("Error adding task to local data source");
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
      );
      await localDataSource.updateTask(taskModel);
    } catch (e) {
      print("Error updating task: $e");
      // Optionally rethrow or handle the exception
      throw Exception("Error updating task in local data source");
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
    } catch (e) {
      print("Error deleting task: $e");
      // Optionally rethrow or handle the exception
      throw Exception("Error deleting task from local data source");
    }
  }
}
