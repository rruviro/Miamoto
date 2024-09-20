import 'package:crud/backend/bloc/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String _selectedYear = "First Year";
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
      body: BlocBuilder<StudentBloc, StudentState>(
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
                      vertical: 30,
                      horizontal: 15
                    ),
                    child: ListView(
                      children: [
                        Column(
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
                                          child: Text(
                                            "25",
                                            style: GoogleFonts.inter(
                                              fontSize: 80, 
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                                bottom: -22,
                                right: -20,
                                child: Image.asset(
                                  'resources/images/student.png',
                                  height: 210,
                                  width: 210,
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
                                                      'Create',
                                                      style: GoogleFonts.inter(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                    Text(
                                                      'create new student',
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
                                                    SizedBox(width: 10), // Add spacing between the TextFormFields
                                                    Expanded(
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          border: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                                                          ),
                                                          hintText: 'Family Name',
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
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
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
                        const SizedBox(height: 15),
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
                                                      'update romero.s detail',
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
                                                    SizedBox(width: 10), // Add spacing between the TextFormFields
                                                    Expanded(
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                          border: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.grey),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Color.fromARGB(255, 11, 166, 222)),
                                                          ),
                                                          hintText: 'Family Name',
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
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: TextFormField(
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
                                      "Romero, Justine Louise",
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
                                    Text(
                                      "Year : First Year | Enrolled",
                                      style: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              },
            );
          } else if (state is StudentError) {
            return Center(child: Text('Failed to load students'));
          } else {
            return Center(child: Text('No students available'));
          }
        },
      ),
    );
  }
}