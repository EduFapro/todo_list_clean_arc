import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'features/todo_list/data/models/task_model.dart';
import 'features/todo_list/domain/usecases/delete_task.dart';
import 'features/todo_list/presentation/controllers/todo_list_controller.dart';
import 'features/todo_list/domain/usecases/add_task.dart';
import 'features/todo_list/domain/usecases/get_tasks.dart';
import 'features/todo_list/domain/usecases/update_task.dart';
import 'features/todo_list/data/repositories/task_repository_impl.dart';
import 'features/todo_list/presentation/pages/todo_list_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskModelAdapter());
  // await Hive.openBox('tasks');

  // Use the singleton instance of TaskRepositoryImpl
  final taskRepository = TaskRepositoryImpl();

  final getTasksUseCase = GetTasks(taskRepository);
  final addTaskUseCase = AddTask(taskRepository);
  final updateTaskUseCase = UpdateTask(taskRepository);
  final deleteTaskUseCase = DeleteTask(taskRepository);

  final todoListController = TodoListController(
    getTodoList: getTasksUseCase,
    addTodo: addTaskUseCase,
    updateTodo: updateTaskUseCase,
    deleteTodo: deleteTaskUseCase
  );

  runApp(MyApp(todoListController: todoListController));
}


class MyApp extends StatelessWidget {
  final TodoListController todoListController;

  const MyApp({super.key, required this.todoListController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Arc Todo List',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: toDoListPage(
        title: 'Clean Arc Todo List',
        controller: todoListController,
      ),
    );
  }
}
