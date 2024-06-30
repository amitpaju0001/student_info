import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/model/reuse_validator_model.dart';
import 'package:student_info/student_detail/model/student_model.dart';
import 'package:student_info/student_detail/provider/form_validator_provider.dart';
import 'package:student_info/student_detail/service/database_service.dart';
import 'package:student_info/student_detail/widget/reuse_text_field.dart';

class UpdateStudentScreen extends StatefulWidget {
  final StudentModel student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  _UpdateStudentScreenState createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {

  Future<void> _selectDate(BuildContext context, FormValidatorProviderUpdate provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        provider.joinDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormValidatorProviderUpdate()..initializeControllers(widget.student),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
        ),
        body: Consumer<FormValidatorProviderUpdate>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReuseTextField(
                        controller: provider.nameController,
                        hintText: 'Name',
                        validator: reuseValidatorModel,
                      ),
                      ReuseTextField(
                        controller: provider.fNameController,
                        hintText: 'Father Name',
                        validator: reuseValidatorModel,
                      ),
                      ReuseTextField(
                        controller: provider.villageController,
                        hintText: 'Village',
                        validator: reuseValidatorModel,
                      ),
                      TextFormField(
                        controller: provider.joinDateController,
                        decoration: InputDecoration(
                          labelText: 'Join Date',
                          hintText: 'Join Date',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, provider),
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
                        validator: reuseValidatorModel,
                        readOnly: true,
                      ),
                      ReuseTextField(
                        controller: provider.feesController,
                        hintText: 'Total Fees',
                        validator: reuseValidatorModel,
                      ),
                      ReuseTextField(
                        controller: provider.pendingFeeController,
                        hintText: 'Pending Fees',
                        validator: reuseValidatorModel,
                      ),
                      ReuseTextField(
                        controller: provider.paidFeeController,
                        hintText: 'Paid Fees',
                        validator: reuseValidatorModel,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (provider.validateForm()) {
                            StudentModel updateStudent = StudentModel(
                              id: widget.student.id,
                              name: provider.nameController.text,
                              fName: provider.fNameController.text,
                              village: provider.villageController.text,
                              fees: provider.feesController.text,
                              image: widget.student.image,
                              joinDate: provider.joinDateController.text,
                              pendingFee: provider.pendingFeeController.text,
                              paidFee: provider.paidFeeController.text,
                            );
                            await DatabaseService().updateStudent(updateStudent);
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

