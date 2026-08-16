abstract class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;

  AddTaskEvent(this.title);
}

class ToggleTaskEvents extends TaskEvent {
  final String taskId;

  ToggleTaskEvents(this.taskId);
}

class DeleteTaskEvents extends TaskEvent {
  final String taskId;

  DeleteTaskEvents(this.taskId);
}
