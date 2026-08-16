import 'package:expensive_tracker_app/src/features/student/bloc/student_event.dart';
import 'package:expensive_tracker_app/src/features/student/bloc/student_state.dart';
import 'package:expensive_tracker_app/src/features/student/data/student_repository.dart';

import '../../../../common_exports.dart';
import '../data/student_model.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repository;

  StudentBloc(this.repository) : super(StudentState()) {
    on<LoadStudentEvents>((event, emit) async {
      try {
        final List<Student> students = await repository.fetchStudents();
        emit(state.copyWith(
          status: StudentStatus.success,
          student: students,
        ));
      } catch (e) {
        emit(state.copyWith(
            status: StudentStatus.failure,
            errorMessage: 'Failed to load Student data.'));
      }
    });
  }
}
