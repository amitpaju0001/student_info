import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/provider/database_provider.dart';
import 'package:student_info/student_detail/ui/screen/add_student_screen.dart';
import 'package:student_info/student_detail/ui/screen/update_student_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {



  @override
  void initState() {
    super.initState();
    loadStudent();
  }

  Future<void> loadStudent() async {
    final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);
    await databaseProvider.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context,);
    final students = databaseProvider.students;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudentScreen(),
            ),
          );
          if (result == true) {
            loadStudent();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: students.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          StudentModel std = students[index];
          return Card(
            elevation: 8,
            margin:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (std.image.isNotEmpty &&
                      File(std.image).existsSync())
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(std.image)),
                        ),
                      ),


                  const SizedBox(
                    height: 16,
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
                  const SizedBox(
                    height: 4,
                  ),
                  Divider(
                    color: Colors.grey.shade100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await Navigator.push(context,
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
                                content: const Text(
                                    'Are you sure you want to delete this student?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await databaseProvider.deleteStudent(std.id!);
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
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 80),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}