import 'package:expensive_tracker_app/src/features/student/data/student_model.dart';

class StudentRepository {
  final List<Student> _studentJsonList = [
    Student(id: 'std1', name: 'Vijay', isPresent: true),
    Student(id: 'std2', name: 'Ram', isPresent: false),
    Student(id: 'std3', name: 'Raj', isPresent: false),
    Student(id: 'std4', name: 'Jogi', isPresent: true),
    Student(id: 'std5', name: 'Rocky', isPresent: false),
  ];

  Future<List<Student>> fetchStudents() async {
    Future.delayed(Duration(milliseconds: 500));
    return List.from(_studentJsonList);
  }
}
