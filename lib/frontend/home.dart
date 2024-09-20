import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _selectedYear = "First Year";

  @override
  Widget build(BuildContext context) {
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
          vertical: 30,
          horizontal: 15
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}