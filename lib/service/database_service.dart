import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_info/model/student_model.dart';
final tableName = 'student';
late Database database;

class DatabaseService{
Future createDatabase()async {
  String dbPath = await getDatabasesPath();
  String dbName = 'school';
  String path = join(dbPath, dbName);
  openDatabase(
    path, version: 1, onCreate: (Database database, int version) async {
    await database.execute(
        'create table $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, fname TEXT, village TEXT,)'
    );
  },);
}
  Future insertStudent(StudentModel student)async{
 await   database.rawInsert('insert into $tableName(name,fname,village)');
  }
  Future getAllStudent() async{
 List<Map<String,dynamic>> mapList =  await database.rawQuery('select * from $tableName');
 List<StudentModel> studentModelList = [];
 for(int i=0;i<mapList.length;i++){
   Map<String,dynamic> map = mapList[i];
   StudentModel studentModel = StudentModel.fromJson(map);
   studentModelList.add(studentModel);
 }
 return studentModelList;
  }
}
