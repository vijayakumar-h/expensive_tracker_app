import '../data/student_model.dart';

enum StudentStatus { initial, loading, success, failure }

class StudentState {
  final StudentStatus status;
  final List<Student> student;
  final String? errorMessage;

  StudentState({
    this.status = StudentStatus.initial,
    this.student = const [],
    this.errorMessage,
  });

  StudentState copyWith({
    final StudentStatus? status,
    final List<Student>? student,
    final String? errorMessage,
  }) {
    return StudentState(
      status: status ?? this.status,
      student: student ?? this.student,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
