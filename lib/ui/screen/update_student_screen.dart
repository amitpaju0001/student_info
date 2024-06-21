import 'package:flutter/material.dart';
import 'package:student_info/model/student_model.dart';
import 'package:student_info/service/database_service.dart';

class UpdateStudentScreen extends StatefulWidget {
  final StudentModel student;

  UpdateStudentScreen({required this.student});

  @override
  _UpdateStudentScreenState createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController villageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    fNameController.text = widget.student.fName;
    villageController.text = widget.student.village;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: fNameController,
              decoration: const InputDecoration(labelText: 'Father Name'),
            ),
            TextFormField(
              controller: villageController,
              decoration: const InputDecoration(labelText: 'Village'),
            ),
            const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  StudentModel  updateStudent =
                    StudentModel(
                      id: widget.student.id,
                      name: nameController.text,
                      fName: fNameController.text,
                      village: villageController.text,
                    );
                    await DatabaseService().updateStudent(updateStudent);
                  Navigator.pop(context, true);
                },
                child: const Text('Save Changes'),
              ),
          ],
        ),
      ),
    );
  }
}
