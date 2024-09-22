class Student {
  final String studentID;
  final String firstname;
  final String lastname;
  final String course;
  final String year;
  final bool enrolled;

  Student({
    required this.studentID,
    required this.firstname,
    required this.lastname,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentID: json['studentID'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      course: json['course'] ?? '',
      year: json['year'] ?? '',
      enrolled: json['enrolled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'firstname': firstname,
      'lastname': lastname,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }
}
