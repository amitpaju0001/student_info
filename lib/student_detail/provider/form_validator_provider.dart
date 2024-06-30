  import 'package:flutter/material.dart';
import 'package:student_info/student_detail/model/student_model.dart';

  class FormValidatorProvider extends ChangeNotifier {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController fNameController = TextEditingController();
    TextEditingController villageController = TextEditingController();
    TextEditingController feesController = TextEditingController();
    TextEditingController joinDateController = TextEditingController();
    TextEditingController pendingFeeController = TextEditingController();
    TextEditingController paidFeeController = TextEditingController();

    bool validateForm() {
      return formKey.currentState?.validate() ?? false;
    }
  }

  class FormValidatorProviderUpdate extends ChangeNotifier {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();
    TextEditingController fNameController = TextEditingController();
    TextEditingController villageController = TextEditingController();
    TextEditingController feesController = TextEditingController();
    TextEditingController joinDateController = TextEditingController();
    TextEditingController pendingFeeController = TextEditingController();
    TextEditingController paidFeeController = TextEditingController();


    void initializeControllers(StudentModel student) {
      nameController.text = student.name;
      fNameController.text = student.fName;
      villageController.text = student.village;
      feesController.text = student.fees;
      joinDateController.text = student.joinDate;
      pendingFeeController.text = student.pendingFee;
      paidFeeController.text = student.paidFee;
    }


    bool validateForm() {
      return formKey.currentState?.validate() ?? false;
    }
  }
  class FormValidatorProviderLogIn extends ChangeNotifier {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    bool validateForm() {
      return formKey.currentState?.validate() ?? false;
    }
  }


  class FormValidatorProviderSignUp extends ChangeNotifier {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    bool validateForm() {
      return formKey.currentState?.validate() ?? false;
    }
  }
