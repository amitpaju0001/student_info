import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/provider/database_provider.dart';
import 'package:student_info/student_detail/provider/form_validator_provider.dart';
import 'package:student_info/student_detail/provider/image_picker_provider.dart';
import 'package:student_info/student_detail/ui/screen/welcome_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return DatabaseProvider();
        },),
        ChangeNotifierProvider(create: (context) {
          return ImagePickProvider();
        },),
        ChangeNotifierProvider(create: (context) {
          return FormValidatorProviderUpdate();
        },),
        ChangeNotifierProvider(create: (context) {
          return FormValidatorProviderSignUp();
        },),
        ChangeNotifierProvider(create: (context) {
          return FormValidatorProviderLogIn();
        },),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  WelcomeScreen(),
      ),
    );
  }
}
