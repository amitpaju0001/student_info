import 'package:flutter/material.dart';
import 'package:student_info/model/student_model.dart';
import 'package:student_info/service/database_service.dart';
import 'package:student_info/ui/screen/add_student_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<StudentModel> students = [];
  @override
  void initState(){
    loadStudent();
    super.initState();
  }
  Future loadStudent() async{
    await Future.delayed(Duration (seconds: 2));
    students = await DatabaseService().getAllStudent();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddStudentScreen();
          },));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: students.length,
          itemBuilder: (context, index) {
          StudentModel studentModel =students[index];
            return Card(
            child: ListTile(
              title: Text(
                studentModel.name
              ),
              subtitle: Text(
                'id: ${studentModel.id} | fName: ${studentModel.fName} | village: ${studentModel.village}'
              ),
              onTap: () {

              },
            ),
          );
          } ,),
    );
  }
}
