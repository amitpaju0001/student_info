
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/model/reuse_validator_model.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/provider/database_provider.dart';
import 'package:student_info/student_detail/provider/form_validator_provider.dart';
import 'package:student_info/student_detail/provider/image_picker_provider.dart';
import 'package:student_info/student_detail/widget/image_pick_widget.dart';
import 'package:student_info/student_detail/widget/reuse_text_field.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  Future<void> _selectDate(BuildContext context,TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
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
    child: Consumer2<FormValidatorProviderUpdate, ImagePickProvider>(
    builder: (context, formValidatorProvider, imagePickProvider, child) {
          return Form(
          key: formValidatorProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImagePickWidget(
                  onImagePicked: (pickedImage) {
                    setState(() {
                    });
                  },
                ),
                ReuseTextField(
                  controller:  formValidatorProvider.nameController,
                  hintText: 'Name',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller:formValidatorProvider.fNameController,
                  hintText: 'Father Name',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: formValidatorProvider.villageController,
                  hintText: 'Village',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: formValidatorProvider.feesController,
                  hintText: 'Total Fees',
                  validator: reuseValidatorModel,
                ),
                TextFormField(
                  controller:  formValidatorProvider.joinDateController,
                  decoration: InputDecoration(
                    labelText: 'Join Date',
                    hintText: 'Join Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                     onPressed: () => _selectDate(context, formValidatorProvider.joinDateController),
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
                  controller: formValidatorProvider.pendingFeeController,
                  hintText: 'Pending Fees',
                  validator: reuseValidatorModel,
                ),
                ReuseTextField(
                  controller: formValidatorProvider.paidFeeController,
                  hintText: 'Paid Fees',
                  validator: reuseValidatorModel,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formValidatorProvider.validateForm()) {
                      StudentModel newStudent = StudentModel(
                        name: formValidatorProvider.nameController.text,
                        fName: formValidatorProvider.fNameController.text,
                        village: formValidatorProvider.villageController.text,
                        fees: formValidatorProvider.feesController.text,
                        image: imagePickProvider.pickedImage?.path ?? '',
                        joinDate: formValidatorProvider.joinDateController.text,
                        pendingFee: formValidatorProvider.pendingFeeController.text,
                        paidFee: formValidatorProvider.paidFeeController.text,
                      );
                      await Provider.of<DatabaseProvider>(context, listen: false).insertStudent(newStudent);
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
    }
      ),
    ),
      ),
    );

  }
}
