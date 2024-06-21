
class StudentModel{
  int? id;
  String name;
  String fName;
  String village;

  StudentModel( {this.id, required this.name,required this.fName,required this.village,});
  Map<String,dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'fName': fName,
      'village': village
    };
    if (id != null) {
      map ['id'] = id;
    }
    return map;
  }
  factory StudentModel.fromMap(Map<String,dynamic> map){
    return StudentModel(
    id: map['id'],
    name: map['name'],
    fName: map['fName'],
    village: map['village'],
    );
  }
}