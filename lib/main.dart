import 'package:crud/backend/bloc/student_bloc.dart';
import 'package:crud/backend/repositories/repository.dart';
import 'package:crud/frontend/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(StudentRepository())..add(LoadStudents()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Universidad ni lucio',
        home: Home(),
      ),
    );
  }
}