import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/student.dart';

class StudentRepository {
  // final String apiUrl = 'http://127.0.0.1/studentApi'; 
  final String apiUrl = 'http://192.168.0.147/studentApi'; 

  Future<List<Student>> fetchStudents() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/read.php'));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if the expected structure exists
        if (jsonResponse.containsKey('students')) {
          final List<dynamic> studentsJson = jsonResponse['students'];

          // Convert the list of dynamic maps into a list of Student objects
          return studentsJson.map((json) => Student.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected data format');
        }
      } else if (response.statusCode == 404) {
        // Handle not found
        throw Exception('No students found');
      } else {
        // Handle other errors
        throw Exception('Error loading students: ${response.statusCode}');
      }
    } catch (e) {
      // Print error details for debugging
      print('Failed to load students: $e');
      throw Exception('Failed to load students: ${e.toString()}');
    }
  }

  Future<void> addStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/create.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );

      if (response.statusCode != 201) {
        print('Failed to add student. Status code: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to add student');
      }
    } catch (e) {
      print('Exception while adding student: $e');
      throw Exception('Failed to add student: ${e.toString()}');
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/update.php?studentID=${student.studentID}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );

      if (response.statusCode != 200) {
        print('Failed to update student. Status code: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to update student');
      }
    } catch (e) {
      print('Exception while updating student: $e');
      throw Exception('Failed to update student: ${e.toString()}');
    }
  }

  Future<void> deleteStudent(int studentID) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/delete.php?studentID=$studentID'),
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        // 204 No Content or 200 OK, deletion is successful
        print('Successfully deleted student with ID: $studentID');
      } else if (response.statusCode == 404) {
        // Student not found
        print('Student with ID $studentID not found.');
        throw Exception('Student not found');
      } else {
        // Other errors
        print('Failed to delete student. Status code: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to delete student');
      }
    } catch (e) {
      print('Exception while deleting student: $e');
      throw Exception('Failed to delete student: ${e.toString()}');
    }
  }

}