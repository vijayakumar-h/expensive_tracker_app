import '../data/task_model.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState {
  final TaskStatus status;
  final List<TaskModel> tasks;
  final String? errorMessage;

  TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const [],
    this.errorMessage,
  });

  TaskState copyWith({
    final TaskStatus? status,
    final List<TaskModel>? tasks,
    final String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
