import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info/student_detail/model/reuse_validator_model.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/service/database_service.dart';
import 'package:student_info/student_detail/widget/image_pick_widget.dart';
import 'package:student_info/student_detail/widget/reuse_text_field.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});
  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}
class _AddStudentScreenState extends State<AddStudentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController joinDateController = TextEditingController();
  TextEditingController pendingFeeController = TextEditingController();
  TextEditingController paidFeeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Students'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImagePickWidget(
                  onImagePicked: (pickedImage) {
                    setState(() {
                      image = pickedImage;
                    });
                  },
                ),
                ReuseTextField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: reuseValidatorModel
                ),
              ReuseTextField(
                  controller: fNameController,
                  hintText: 'Father Name',
                  validator: reuseValidatorModel
              ),ReuseTextField(
              controller: villageController,
              hintText: 'Village',
              validator: reuseValidatorModel
                  ),
                ReuseTextField(
                    controller: feesController,
                    hintText: 'Total Fees',
                    validator: reuseValidatorModel
                ),
                ReuseTextField(
                    controller: joinDateController,
                    hintText: 'Joining Date',
                    validator: reuseValidatorModel
                ),
                ReuseTextField(
                    controller: pendingFeeController,
                    hintText: 'Pending Fees',
                    validator: reuseValidatorModel
                ),
                ReuseTextField(
                    controller: paidFeeController,
                    hintText: 'Paid Fees',
                    validator: reuseValidatorModel
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: ()async {
                  if(formKey.currentState?.validate()?? false) {
                    StudentModel newStudent = StudentModel(
                        name: nameController.text,
                        fName: fNameController.text,
                        village: villageController.text,
                        fees: feesController.text,
                        image: imageController.text,
                        joinDate: joinDateController.text,
                        pendingFee: pendingFeeController.text,
                        paidFee: paidFeeController.text
                    );
                    DatabaseService databaseService = DatabaseService();
                    await databaseService.insertStudent(newStudent);
                  }
                  }, child: const Text('add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}