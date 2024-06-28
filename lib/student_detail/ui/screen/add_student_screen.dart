import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/model/reuse_validator_model.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/provider/database_provider.dart';
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
  TextEditingController joinDateController = TextEditingController();
  TextEditingController pendingFeeController = TextEditingController();
  TextEditingController paidFeeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  File? image;

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
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: fNameController,
                  hintText: 'Father Name',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: villageController,
                  hintText: 'Village',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: feesController,
                  hintText: 'Total Fees',
                  validator: reuseValidatorModel,
                ),
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
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: paidFeeController,
                  hintText: 'Paid Fees',
                  validator: reuseValidatorModel,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      StudentModel newStudent = StudentModel(
                        name: nameController.text,
                        fName: fNameController.text,
                        village: villageController.text,
                        fees: feesController.text,
                        image: image?.path ?? '',
                        joinDate: joinDateController.text,
                        pendingFee: pendingFeeController.text,
                        paidFee: paidFeeController.text,
                      );
                      await Provider.of<DatabaseProvider>(context, listen: false).insertStudent(newStudent);
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
