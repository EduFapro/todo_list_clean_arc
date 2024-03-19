import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {

  final TaskLocalDataSource localDataSource;

  static final TaskRepositoryImpl _singleton = TaskRepositoryImpl._internal(TaskLocalDataSource());

  TaskRepositoryImpl._internal(this.localDataSource);

  factory TaskRepositoryImpl() => _singleton;

  @override
  Future<List<Task>> getTasks() async {
    return await localDataSource.getTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    await localDataSource.addTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await localDataSource.updateTask(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }
}
