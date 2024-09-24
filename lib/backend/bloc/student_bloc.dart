import 'package:crud/backend/repositories/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:crud/backend/model/student.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repository;

  StudentBloc(this.repository) : super(StudentLoading()) {
    
    on<LoadStudents>((event, emit) async {
      try {
        final students = await repository.fetchStudents();
        final studentCount = students.length;
        print('Data loaded: $studentCount students found');
        emit(StudentLoaded(students, studentCount));
        if (studentCount == 0) {
          emit(const StudentError("No students found"));
        } else {
          emit(StudentLoaded(students, studentCount));
        }
      } catch (e) {
        emit(const StudentError("Failed to load students"));
      }
    });

    on<AddStudent>((event, emit) async {
      try {
        emit(StudentLoading()); // Emit loading state
        await repository.addStudent(event.student);

        // After adding the student, re-fetch the students
        final students = await repository.fetchStudents();
        final updatedCount = students.length;

        emit(StudentLoaded(students, updatedCount)); // Emit updated list
      } catch (e) {
        emit(const StudentError("Failed to add student"));
      }
    });

    on<UpdateStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.updateStudent(event.student);
          final updatedStudents = (state as StudentLoaded)
              .students
              .map((student) => student.studentID == event.student.studentID ? event.student : student)
              .toList();
          final updatedCount = updatedStudents.length;
          emit(StudentLoaded(updatedStudents, updatedCount));
        } catch (e) {
          emit(const StudentError("Failed to update student"));
        }
      }
    });

    on<DeleteStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          // Call the repository to delete the student using String ID
          await repository.deleteStudent(int.parse(event.studentID));
          
          // Update the list of students after deletion
          final updatedStudents = (state as StudentLoaded)
              .students
              .where((student) => student.studentID != event.studentID)
              .toList();
          final updatedCount = updatedStudents.length;
          
          emit(StudentLoaded(updatedStudents, updatedCount));
        } catch (e) {
          emit(const StudentError("Failed to delete student"));
        }
      }
    });

  }
}
