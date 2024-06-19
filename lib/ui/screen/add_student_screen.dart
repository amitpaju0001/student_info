import 'package:flutter/material.dart';
import 'package:student_info/model/student_model.dart';
import 'package:student_info/service/database_service.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Students'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name'
              ),
            ),TextField(
              controller: fNameController,
              decoration: InputDecoration(
                labelText: 'Father Name'
              ),
            ),TextField(
              controller: villageController,
              decoration: InputDecoration(
                labelText: 'Village'
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async {
              StudentModel newStudent = StudentModel(name: nameController.text,
                  fName: fNameController.text,
                  village: villageController.text);
              DatabaseService databaseService = DatabaseService();
             await databaseService.insertStudent(newStudent);
            }, child: Text('add'))
          ],
        ),
      ),
    );
  }
}
