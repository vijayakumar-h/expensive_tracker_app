import 'package:expensive_tracker_app/src/features/tasks/data/task_model.dart';

class TaskRepository {
  final List<TaskModel> _mockTasks = [
    TaskModel(id: '1', title: 'Buy groceries', isComplete: false),
    TaskModel(id: '2', title: 'Review BLoC architecture', isComplete: true),
  ];

  Future<List<TaskModel>> fetchTasks() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockTasks);
  }

  Future<TaskModel> addTask(String title) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final TaskModel newTask = TaskModel(
        id: DateTime.fromMicrosecondsSinceEpoch.toString(), title: title);
    _mockTasks.add(newTask);
    return newTask;
  }

  Future<void> toggleTaskStatus(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final int index = _mockTasks.indexWhere((type) => type.id == id);
    if (index != -1) {
      _mockTasks[index] = _mockTasks[index].copyWith(
        isComplete: !_mockTasks[index].isComplete,
      );
    }
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mockTasks.removeWhere((type) => type.id == id);
  }
}
