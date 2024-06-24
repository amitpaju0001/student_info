import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickService{
  final ImagePicker imagePicker = ImagePicker();
  Future<File?> pickImage ()async{
    final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      return File(pickedImage.path);
    }
    return null;
  }
}



