import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/service/database_service.dart';
import 'package:student_info/student_detail/ui/screen/add_student_screen.dart';
import 'package:student_info/student_detail/ui/screen/update_student_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<StudentModel> students = [];
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    loadStudent();
    super.initState();
  }

  Future loadStudent() async {
    students = await DatabaseService().fetchStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddStudentScreen();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          StudentModel std = students[index];
          return  Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (std.image.isNotEmpty)
                      Image.file(
                        File(std.image),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    studentRecord('Name', std.name),
                    const SizedBox(height: 8),
                    studentRecord('Father Name', std.fName),
                    const SizedBox(height: 8),
                    studentRecord('Village', std.village),
                    const SizedBox(height: 8),
                    studentRecord('Joining Date', std.joinDate),
                    const SizedBox(height: 8),
                    studentRecord('Pending Fees', std.pendingFee),
                    const SizedBox(height: 8),
                    studentRecord('Paid Fees', std.paidFee),
                    const SizedBox(height: 8),
                    studentRecord('Total Fees', std.fees),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UpdateStudentScreen(student: std);
                              }));
                              loadStudent();
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Student'),
                                  content: const Text('Are you sure you want to delete this student?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await DatabaseService.deleteStudent(std.id!);
                                        loadStudent();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }

  Widget studentRecord(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
