import 'package:expensive_tracker_app/src/features/student/bloc/student_bloc.dart';
import 'package:expensive_tracker_app/src/features/student/bloc/student_event.dart';
import 'package:expensive_tracker_app/src/features/student/bloc/student_state.dart';
import 'package:expensive_tracker_app/src/features/student/data/student_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/student_model.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(StudentRepository())
        ..add(
          LoadStudentEvents(),
        ),
      child: StudentView(),
    );
  }
}

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
        if (state.status == StudentStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == StudentStatus.failure) {
          return Text(state.errorMessage ?? 'An error occoured');
        }

        if (state.student.isEmpty) {
          return Text('Student Data has been empty');
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.student.length,
            itemBuilder: (context, index) {
              final Student student = state.student.elementAt(index);
              return Text(student.name);
            });
      }),
    );
  }
}
