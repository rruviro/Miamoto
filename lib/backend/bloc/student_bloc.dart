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
        print('Data loaded: ${students.length} students found');
        if (students.isEmpty) {
          print('No students in the database');
        }
        emit(StudentLoaded(students));
      } catch (e) {
        print('Error loading data: $e');
        emit(const StudentError("Failed to load students"));
      }
    });

    on<AddStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.addStudent(event.student);
          print('Student added: ${event.student}');
          final currentStudents = (state as StudentLoaded).students;
          final updatedStudents = List<Student>.from(currentStudents)
            ..add(event.student);
          emit(StudentLoaded(updatedStudents));
        } catch (e) {
          print('Error adding student: $e');
          emit(const StudentError("Failed to add student"));
        }
      } else {
        print('State is not StudentLoaded');
      }
    });

    on<UpdateStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.updateStudent(event.student);
          print('Student updated: ${event.student}');
          final updatedStudents = (state as StudentLoaded)
              .students
              .map((student) => student.studentID == event.student.studentID ? event.student : student)
              .toList();
          emit(StudentLoaded(updatedStudents));
        } catch (e) {
          print('Error updating student: $e');
          emit(const StudentError("Failed to update student"));
        }
      }
    });

    on<DeleteStudent>((event, emit) async {
      if (state is StudentLoaded) {
        try {
          await repository.deleteStudent(event.studentID);
          print('Successfully deleted student with ID: ${event.studentID}');
          final updatedStudents = (state as StudentLoaded)
              .students
              .where((student) => student.studentID != event.studentID)
              .toList();
          emit(StudentLoaded(updatedStudents));
        } catch (e, stackTrace) {
          print('Error deleting student: $e');
          print('Stack trace: $stackTrace');
          emit(StudentError('Failed to delete student: $e'));
        }
      }
    });
  }
}