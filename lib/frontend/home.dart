// ignore_for_file: prefer_const_constructors
import 'package:crud/backend/bloc/student_bloc.dart';
import 'package:crud/backend/model/student.dart';
import 'package:crud/frontend/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final Student? student;
  const Home({super.key, this.student});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 11, 166, 222),
        title: Center(
          child: Text(
            "Universidad ni upang",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true, 
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Admin!",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  Text(
                    "Today is the great day pag kasama mo ako!",
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 166, 222),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(138, 0, 0, 0).withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(1, 8),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 25,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 90,
                          child: Center(
                            child: FittedBox(
                              child: BlocBuilder<StudentBloc, StudentState>(
                                builder: (context, state) {
                                  if (state is StudentLoading) {
                                    return CircularProgressIndicator(); 
                                  } else if (state is StudentLoaded) {
                                    return Text(
                                      "${state.studentCount}",
                                      style: GoogleFonts.inter(
                                        fontSize: 80,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  } else if (state is StudentError) {
                                    return Text(
                                      state.message,
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.contacts,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "Total Students",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  Positioned(
                    bottom: -23,
                    right: -20,
                    child: Image.asset(
                      'resources/images/student.png',
                      height: 220,
                      width: 220,
                    )
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 35,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overview",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "Student Details",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w400
                          )
                        ),
                      ],
                    )
                  ),
                  Positioned(
                    top: 5,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                        _showCreateDialog(context);
                      },
                      child: Icon(
                        Icons.group_add_sharp,
                        color: Color.fromARGB(255, 11, 166, 222),
                      ),
                    )
                  )
                ],
              ),
            ),
            Container(
              height: 620,
              child: BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentLoaded) {
                    final students = state.students;
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 200),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(138, 0, 0, 0).withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 100,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(255, 11, 166, 222),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 15,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => detail(student: student),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 11, 166, 222),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.arrow_outward_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                              _showDeleteDialog(context, student);
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
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 30,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${student.lastname}, ${student.firstname}",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Course: ${student.course}",
                                            style: GoogleFonts.inter(
                                              color: Colors.grey,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Year: ${student.year} |",
                                                style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                student.enrolled ? 'Enrolled' : 'Not Enrolled',
                                                style: GoogleFonts.inter(
                                                  color: student.enrolled
                                                      ? Color.fromARGB(255, 11, 166, 222)
                                                      : Colors.red,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is StudentError) {
                    return Center(child: Text(state.message));
                  }
                  return Container(); 
                },
              ),
            ),
          ]
        ),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _courseController = TextEditingController();
    String _selectedYear = 'First Year';
    bool _isEnrolled = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(Icons.drive_folder_upload_outlined),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Student',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Enter new student details',
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          content: Container(
            height: 300,
            width: double.infinity,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
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
                              hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || value.isEmpty ? 'First name is required' : null,
                          ),
                        ),
                        SizedBox(width: 10),
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
                              hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _courseController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                        ),
                        hintText: 'Course',
                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedYear,
                      items: [
                        DropdownMenuItem(value: 'First Year', child: Text('First Year', style: GoogleFonts.inter(fontSize: 13))),
                        DropdownMenuItem(value: 'Second Year', child: Text('Second Year', style: GoogleFonts.inter(fontSize: 13))),
                        DropdownMenuItem(value: 'Third Year', child: Text('Third Year', style: GoogleFonts.inter(fontSize: 13))),
                        DropdownMenuItem(value: 'Fourth Year', child: Text('Fourth Year', style: GoogleFonts.inter(fontSize: 13))),
                        DropdownMenuItem(value: 'Fifth Year', child: Text('Fifth Year', style: GoogleFonts.inter(fontSize: 13))),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Year',
                        labelStyle: TextStyle(fontSize: 15),
                        prefixIcon: const Icon(Icons.calendar_month_outlined, color: Color.fromARGB(255, 11, 166, 222)),
                      ),
                      validator: (value) => value == null ? 'Year is required' : null,
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('Enrolled', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: _isEnrolled,
                            onChanged: (value) {
                              setState(() {
                                _isEnrolled = value;
                                print("Switch is now: $_isEnrolled");
                              });
                            },
                            activeColor: Color.fromARGB(255, 11, 166, 222),
                            inactiveThumbColor: Colors.red,
                            inactiveTrackColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_firstNameController.text.isEmpty ||
                            _lastNameController.text.isEmpty ||
                            _courseController.text.isEmpty ||
                            _selectedYear.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF0BA6DE),
                              content: Text('Please fill in all fields'),
                            ),
                          );
                          return;
                        }
                        
                        final studentData = Student(
                          studentID: '',
                          firstname: _firstNameController.text,
                          lastname: _lastNameController.text,
                          course: _courseController.text,
                          year: _selectedYear,
                          enrolled: _isEnrolled,
                        );

                        try {
                          context.read<StudentBloc>().add(AddStudent(studentData));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0xFF0BA6DE),
                              content: Text('New student added'),
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          print('Error adding student: $e');
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
                          'Create',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }


  void _showDeleteDialog (BuildContext context, Student student) {
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
                'Do you insist deleting ${student.lastname}\'s details',
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
                context.read<StudentBloc>().add(DeleteStudent(student.studentID));
                Navigator.pop(context);
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

}