import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: source
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    debugPrint("Lỗi khi chọn ảnh: $e"); 
    return null;
  }
}

Future<File?> pickImageFromCamera() async {
  return await pickImage(ImageSource.camera);
}

Future<File?> pickImageFromGallery() async {
  return await pickImage(ImageSource.gallery);
}

void selectImage() async {
  final imageFromCamera = await pickImageFromCamera();
  if (imageFromCamera != null) {
    print('Ảnh từ camera: ${imageFromCamera.path}');
  } else {
    print('Không chọn ảnh từ camera.');
  }

  // Chọn ảnh từ thư viện
  final imageFromGallery = await pickImageFromGallery();
  if (imageFromGallery != null) {
    print('Ảnh từ thư viện: ${imageFromGallery.path}');
  } else {
    print('Không chọn ảnh từ thư viện.');
  }
}
