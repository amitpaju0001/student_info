import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:student_info/model/student_model.dart';
const tableName = 'student';

class DatabaseService {
  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'school';
    String path = join(dbPath, dbName);
   return openDatabase(
      path, version: 1, onCreate: (Database database, int version) async {
     await database.execute(
       'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, fName TEXT, village TEXT)',
      );
    },);
  }

  Future insertStudent(StudentModel student) async {
    Database database = await getDatabase();
    await database.rawInsert(
        'insert into $tableName(name,fName,village) values(?,?,?)',
        [student.name, student.fName, student.village]);
  }

  Future<List<StudentModel>> fetchStudents() async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> mapList = await database.rawQuery(
        'select * from $tableName');
    List<StudentModel> studentModelList = [];
    for (int i = 0; i < mapList.length; i++) {
      studentModelList.add(StudentModel.fromMap(mapList[i]));
    }
    return studentModelList;
  }
}