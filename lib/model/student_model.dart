class StudentModel{
  int? id;
  String name;
  String fName;
  String village;

  StudentModel({required this.name,required this.fName,required this.village,this.id});
  factory StudentModel.fromJson(Map<String,dynamic>json){
    return StudentModel
      (
        id: json['id'],name: json['name'], fName: json['fName'], village: json['village']);
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data ['id'] = id;
    data['name'] = name;
    data['fName'] = fName;
    data['village'] = village;
    return data;
  }
}