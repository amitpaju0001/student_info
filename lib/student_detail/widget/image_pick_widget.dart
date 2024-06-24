import 'package:flutter/material.dart';
import 'dart:io';

import 'package:student_info/student_detail/service/image_picker_service.dart';

class ImagePickWidget extends StatefulWidget {
  final Function(File?) onImagePicked;

  const ImagePickWidget({super.key, required this.onImagePicked});

  @override
  ImagePickWidgetState createState() => ImagePickWidgetState();
}
class ImagePickWidgetState extends State<ImagePickWidget> {
  File? image;
  final ImagePickService imagePickService = ImagePickService();
  Future pickImage() async {
    final File? pickedImage = await imagePickService.pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
      widget.onImagePicked(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: image == null
          ? Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(40),
        ),
        height: 150,
        width: 150,
        child: const Icon(Icons.add_a_photo, size: 50),
      )
          : Image.file(
        image!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
