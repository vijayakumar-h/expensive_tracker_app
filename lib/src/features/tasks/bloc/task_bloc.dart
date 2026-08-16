import 'package:expensive_tracker_app/src/features/tasks/bloc/task_event.dart';
import 'package:expensive_tracker_app/src/features/tasks/bloc/task_state.dart';
import 'package:expensive_tracker_app/src/features/tasks/data/task_repository.dart';

import '../../../../common_exports.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskState()) {
    // 1. Fetch Initial Tasks
    on<LoadTaskEvent>((event, emit) async {
      try {
        final tasks = await repository.fetchTasks();
        emit(state.copyWith(
          status: TaskStatus.success,
          tasks: tasks,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: TaskStatus.failure,
          errorMessage: 'Failed to load tasks',
        ));
      }
    });

    // 2. Add New Task
    on<AddTaskEvent>((event, emit) async {
      try {
        final newTask = await repository.addTask(event.title);
        final updatedList = List.of(state.tasks..add(newTask));
        emit(state.copyWith(tasks: updatedList));
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Could not add task'));
      }
    });

    // 3. Toggle Completion Status
    on<ToggleTaskEvents>((event, emit) async {
      try {
        await repository.toggleTaskStatus(event.taskId);
        final updatedList = state.tasks.map((task) {
          if (task.id == event.taskId) {
            return task.copyWith(isComplete: !task.isComplete);
          }
          return task;
        }).toList();
        emit(state.copyWith(tasks: updatedList));
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Failed to update task'));
      }
    });

    // 4. Delete Task
    on<DeleteTaskEvents>((event, emit) async {
      try {
        await repository.deleteTask(event.taskId);
        final updatedList =
            state.tasks.where((type) => type.id == event.taskId).toList();
        emit(state.copyWith(tasks: updatedList));
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Failed to delete task'));
      }
    });
  }
}
