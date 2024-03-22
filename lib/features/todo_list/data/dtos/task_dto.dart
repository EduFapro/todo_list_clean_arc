import '../../domain/entities/task.dart';
import '../models/task_model.dart';

class TaskDTO {
  final String id;
  final String title;
  final bool isCompleted;

  TaskDTO({required this.id, required this.title, this.isCompleted = false});

  factory TaskDTO.fromJson(Map<String, dynamic> json) {
    return TaskDTO(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }


  Task toEntity() {
    return Task(id: id, title: title, isCompleted: isCompleted);
  }

  factory TaskDTO.fromEntity(Task task) {
    return TaskDTO(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
  }

  TaskModel toModel() {
    return TaskModel(id: id, title: title, isCompleted: isCompleted);
  }


  factory TaskDTO.fromModel(TaskModel model) {
    return TaskDTO(
      id: model.id,
      title: model.title,
      isCompleted: model.isCompleted,
    );
  }
}
