import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info/model/reuse_validator_model.dart';
import 'package:student_info/model/student_model.dart';
import 'package:student_info/service/database_service.dart';
import 'package:student_info/widget/image_pick_widget.dart';
import 'package:student_info/widget/reuse_text_field.dart';

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
        title: Text('Add Students'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
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
                SizedBox(height: 20,),
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
                  }, child: Text('add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
