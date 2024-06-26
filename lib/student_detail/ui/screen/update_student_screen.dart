import 'package:flutter/material.dart';
import 'package:student_info/student_detail/model/reuse_validator_model.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/service/database_service.dart';
import 'package:student_info/student_detail/widget/reuse_text_field.dart';


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
  TextEditingController feesController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController joinDateController = TextEditingController();
  TextEditingController pendingFeeController = TextEditingController();
  TextEditingController paidFeeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    fNameController.text = widget.student.fName;
    villageController.text = widget.student.village;
    feesController.text = widget.student.fees;
    imageController.text = widget.student.image;
    joinDateController.text = widget.student.joinDate;
    pendingFeeController.text = widget.student.pendingFee;
    paidFeeController.text = widget.student.paidFee;
  }
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        joinDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReuseTextField(
                    controller: nameController,
                    hintText: 'Name',
                    validator: reuseValidatorModel),
                ReuseTextField(
                    controller: fNameController,
                    hintText: 'Father Name',
                    validator: reuseValidatorModel),
                ReuseTextField(
                    controller: villageController,
                    hintText: 'Village',
                    validator: reuseValidatorModel),
                ReuseTextField(
                    controller: feesController,
                    hintText: 'Total Fees',
                    validator: reuseValidatorModel),
                TextFormField(
                  controller:  joinDateController,
                  decoration: InputDecoration(
                    labelText: 'Join Date',
                    hintText: 'Join Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator:reuseValidatorModel ,
                  readOnly: true,
                ),
                ReuseTextField(
                    controller: pendingFeeController,
                    hintText: 'Pending Fees',
                    validator: reuseValidatorModel),
                ReuseTextField(
                    controller: paidFeeController,
                    hintText: 'Paid Fees',
                    validator: reuseValidatorModel),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    StudentModel updateStudent = StudentModel(
                        id: widget.student.id,
                        name: nameController.text,
                        fName: fNameController.text,
                        village: villageController.text,
                        fees: feesController.text,
                        image: imageController.text,
                        joinDate: joinDateController.text,
                        pendingFee: pendingFeeController.text,
                        paidFee: paidFeeController.text);
                    await DatabaseService().updateStudent(updateStudent);
                    Navigator.pop(context, true);
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
