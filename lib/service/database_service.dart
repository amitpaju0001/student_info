import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:student_info/model/student_model.dart';


class DatabaseService {
  static Database? _database;
  static String tableName = 'student';

 static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

 static Future _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String dbName = 'school.db';
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

  Future<int> updateStudent(StudentModel student) async {
      Database database = await getDatabase();
      String sql = '''
      UPDATE $tableName 
      SET name = ?, fName = ?, village = ? 
      WHERE id = ?
    ''';
      return await database.rawUpdate(sql, [
        student.name,
        student.fName,
        student.village,
        student.id,
      ]);

  }
  static Future<int> deleteStudent(int id) async {
    Database database = await getDatabase();
  String sql  = 'delete from $tableName where id = ?';
   return await database.rawDelete(sql,[id]);
  }


}