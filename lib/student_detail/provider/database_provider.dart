import 'package:flutter/material.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/auth/model/user_model.dart';
import 'package:student_info/student_detail/service/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  List<StudentModel> students = [];
  List<StudentModel> get student => students;
  final DatabaseService databaseService = DatabaseService();

  Future<void> insertStudent(StudentModel student) async {
    await databaseService.insertStudent(student);
    students.add(student);
    notifyListeners();
  }


  Future<void> registerUser(UserModel userModel) async {
    await databaseService.registerUser(userModel);
    notifyListeners();
  }

  Future<bool> isUserExists(String email) async {
    return await databaseService.isUserExists(email);
  }

  Future<bool> login(String email, String password) async {
    return await databaseService.login(email, password);
  }

  Future<void> fetchStudents() async {
    students = await databaseService.fetchStudents();
    notifyListeners();
  }


  Future<void> updateStudent(StudentModel student) async {
    await databaseService.updateStudent(student);
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await DatabaseService.deleteStudent(id);
    notifyListeners();
  }
}
