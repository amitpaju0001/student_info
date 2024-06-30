import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_info/student_detail/provider/image_picker_provider.dart';

class ImagePickWidget extends StatelessWidget {
  final Function(File) onImagePicked;

  const ImagePickWidget({super.key, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    final imagePickProvider = Provider.of<ImagePickProvider>(context);

    return Column(
      children: [
        InkWell(
          onTap: () async {
            await imagePickProvider.pickImage();
            if (imagePickProvider.pickedImage != null) {
              onImagePicked(imagePickProvider.pickedImage!);
            }
          },
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: imagePickProvider.pickedImage != null
                ? FileImage(imagePickProvider.pickedImage!)
                : null,
            child: imagePickProvider.pickedImage == null
                ? const Icon(
              Icons.camera_alt,
              size: 50,
              color: Colors.grey,
            )
                : null,
          ),
        ),
        if (imagePickProvider.pickedImage != null) const SizedBox(height: 10),
        if (imagePickProvider.pickedImage != null)
          const Text('Tap to change image',
              style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
