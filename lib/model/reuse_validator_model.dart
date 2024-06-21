String? reuseValidatorModel(String? value){
  if(value == null|| value.isEmpty){
    return 'this field is required';
  }
  return null;
}


// return Scaffold(
// appBar: AppBar(
// title: const Text('Student Home'),
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// Navigator.push(context, MaterialPageRoute(builder: (context) {
// return const AddStudentScreen();
// },));
// },
// child: const Icon(Icons.add),
// ),
// body: ListView.builder(
// itemCount: students.length,
// itemBuilder: (context, index) {
// StudentModel studentModel =students[index];
// return Card(
// child: ListTile(
// title: Text(
// studentModel.name
// ),
// subtitle: Text(
// 'id: ${studentModel.id} | fName: ${studentModel.fName} | village: ${studentModel.village}'
// ),
// trailing: SizedBox(
// width: 100,
// child: Row(
// children: [
// IconButton(onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context)  {
// return UpdateStudentScreen(student: studentModel);
// }
// ));
// loadStudent();
// }, icon: const Icon(Icons.edit)),
// IconButton(onPressed: ()async {
// DatabaseService.deleteStudent(studentModel.id!);
// loadStudent();
// }, icon: const Icon(Icons.delete)),
// ],
// ),
// ),
// onTap: () {
// },
// ),
// );
// } ,),
// );