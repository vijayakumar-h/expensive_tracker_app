abstract class StudentEvent {}

class LoadStudentEvents extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  final String name;

  AddStudentEvent(this.name);
}
