import 'package:crud/backend/bloc/student_bloc.dart';
import 'package:crud/backend/model/student.dart';
import 'package:flutter/material.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 166, 222),
        title: Center(
          child: Text(
            "Everyday is blue",
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
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
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
                    "Today is the great day pag kasama mo ako",
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
                                  return SizedBox(); // Return empty box if no state matches
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
                    bottom: -26,
                    right: -20,
                    child: Image.asset(
                      'resources/images/student.png',
                      height: 250,
                      width: 250,
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
              height: screenHeight,
              child: BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentLoaded) {
                    final students = state.students;
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
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
                                            bottomLeft: Radius.circular(10)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap:(){  
                                          _showUpdateDialog(context, student);
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(255, 11, 166, 222),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_outward_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
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
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          Text(
                                            "Course : Bachelor of information in science",
                                            style: GoogleFonts.inter(
                                              color: Colors.grey,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Year : ${student.year} |",
                                                style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                student.enrolled ? 'Enrolled' : 'Not Enrolled',
                                                style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ]
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

  void _showUpdateDialog(BuildContext context, Student student) {
    final TextEditingController _firstNameController = TextEditingController(text: student.firstname);
    final TextEditingController _LastNameController = TextEditingController(text: student.lastname);
    final TextEditingController _courseController = TextEditingController(text: student.course);
    int _countFirstName = student.firstname.length;
    int _countLastName = student.lastname.length;
    String _selectedYear = "First Year";

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
                  padding: EdgeInsets.only(
                    top: 5
                  ),
                  child: Icon(
                    Icons.drive_folder_upload_outlined,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'update ${student.lastname} detail',
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          content: Container(
            height: 260,
            width: double.infinity,
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
                          hintText: 'Given name',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          suffix: Text(
                            '$_countFirstName/25',
                            style: TextStyle(
                              color: Color.fromARGB(255, 11, 166, 222),
                              fontSize: 12,
                            ),
                          ),
                          suffixStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
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
                        controller: _LastNameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                          ),
                          hintText: 'Surname',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          suffix: Text(
                            '${_countLastName}/23',
                            style: TextStyle(
                              color: Color.fromARGB(255, 11, 166, 222),
                              fontSize: 12,
                            ),
                          ),
                          suffixStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
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
                      suffix: Text(
                        '2/23', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 166, 222),
                          fontSize: 12,
                        ),
                      ),
                      suffixStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 11, 166, 222), 
                    minimumSize: Size(double.infinity, 60), 
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
                )
              ],
            ),
          )
        );
      },
    );
  }

}