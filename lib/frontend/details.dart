// ignore_for_file: prefer_const_constructors
import 'package:crud/backend/bloc/student_bloc.dart';
import 'package:crud/backend/model/student.dart';
import 'package:crud/frontend/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class detail extends StatefulWidget {
  final Student? student;
  const detail({super.key, this.student});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  String _selectedYear = "First Year";
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstname;
      _lastNameController.text = widget.student!.lastname;
      _courseController.text = widget.student!.course;
      _selectedYear = widget.student!.year;
      _isEnrolled = widget.student!.enrolled;
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 11, 166, 222),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform.translate(
          offset: Offset(-15.0, 0.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update',
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  'Change detail of',
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 11,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap:(){  
              _showDeleteDialog(context, widget.student!.lastname, widget.student!.studentID);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 67, 58),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                      ),
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                  ),
                ),
                SizedBox(width: 10), // Add spacing between the TextFormFields
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                      ),
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                controller: _courseController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                  ),
                  hintText: 'Course',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              items: [
                DropdownMenuItem(
                  value: 'First Year',
                  child: Text('First Year', style: GoogleFonts.inter(fontSize: 13)),
                ),
                DropdownMenuItem(
                  value: 'Second Year',
                  child: Text('Second Year', style: GoogleFonts.inter(fontSize: 13)),
                ),
                DropdownMenuItem(
                  value: 'Third Year',
                  child: Text('Third Year', style: GoogleFonts.inter(fontSize: 13)),
                ),
                DropdownMenuItem(
                  value: 'Fourth Year',
                  child: Text('Fourth Year', style: GoogleFonts.inter(fontSize: 13)),
                ),
                DropdownMenuItem(
                  value: 'Fifth Year',
                  child: Text('Fifth Year', style: GoogleFonts.inter(fontSize: 13)),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedYear = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Year',
                labelStyle: TextStyle(
                  fontSize: 15
                ),
                prefixIcon: const Icon(
                  Icons.calendar_month_outlined, 
                  color: Color.fromARGB(255, 11, 166, 222)
                ),
              ),
              validator: (value) => value == null ? 'Year is required' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_firstNameController.text.isEmpty ||
                  _lastNameController.text.isEmpty ||
                  _courseController.text.isEmpty ||
                  _selectedYear.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xFF0BA6DE),
                      content: Text('Please fill in all fields')
                    ),
                  );
                  return;
                }

                final studentData = Student(
                  studentID: widget.student?.studentID ?? const Uuid().v4(),
                  firstname: _firstNameController.text,
                  lastname: _lastNameController.text,
                  course: _courseController.text,
                  year: _selectedYear,
                  enrolled: _isEnrolled,
                );

                try {
                  // Compare the new values with the existing student's details
                  bool hasChanged = widget.student?.firstname != studentData.firstname ||
                      widget.student?.lastname != studentData.lastname ||
                      widget.student?.course != studentData.course ||
                      widget.student?.year != studentData.year ||
                      widget.student?.enrolled != studentData.enrolled;

                  if (!hasChanged) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color(0xFF0BA6DE),
                        content: Text('No changes were made to ${studentData.lastname}\'s details.'),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    context.read<StudentBloc>().add(UpdateStudent(studentData));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color(0xFF0BA6DE),
                        content: Text('Successfully updated ${studentData.lastname}\'s details.'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print('Error updating student: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color(0xFF0BA6DE),
                      content: Text('Failed to save student: $e'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0BA6DE), 
                minimumSize: Size(double.infinity, 50), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), 
                ),
              ),
              child: Center(
                child: Text(
                  'Update',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ) 
            ),
          ],
        ),
      ),
    );
  }
}

void _showDeleteDialog (BuildContext context, String lastname, String studentID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              'Do you insist deleting ${lastname}\'s details',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
              context.read<StudentBloc>().add(DeleteStudent(studentID));
            },
            child: Container(
              height: 30,
              width: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Color.fromARGB(255, 11, 166, 222)
              ),
              child: Center( 
                child: Text(
                  'Yes',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600 
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Color.fromARGB(255, 11, 166, 222),
              ),
              child: Center(
                child:Text(
                  'No',
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(190, 255, 255, 255),
                    fontSize: 13,
                    fontWeight: FontWeight.w600 
                  ),
                ),
              )
            ),
          ),
        ],
      );
    }
  );
}