// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:photo_view/photo_view.dart';

// import 'pick_image.dart';

// class ImagePickerWithPhotoView extends StatefulWidget {
//   @override
//   _ImagePickerWithPhotoViewState createState() =>
//       _ImagePickerWithPhotoViewState();
// }

// class _ImagePickerWithPhotoViewState extends State<ImagePickerWithPhotoView> {
//   File? _selectedImage;

//   Future<void> _selectImage(ImageSource source) async {
//     final pickedImage = await pickImage(source);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = pickedImage;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Chọn và Điều chỉnh ảnh")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _selectedImage != null
//                 ? Container(
//                     height: 300,
//                     width: 300,
//                     color: Colors.grey[300],
//                     child: PhotoView(
//                       imageProvider: FileImage(_selectedImage!),
//                       backgroundDecoration:
//                           BoxDecoration(color: Colors.grey[300]),
//                       minScale: PhotoViewComputedScale.contained * 0.8,
//                       maxScale: PhotoViewComputedScale.covered * 3.0,
//                     ),
//                   )
//                 : const Text("Chưa chọn ảnh"),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectImage(ImageSource.camera),
//               child: const Text("Chụp ảnh"),
//             ),
//             ElevatedButton(
//               onPressed: () => _selectImage(ImageSource.gallery),
//               child: const Text("Chọn từ thư viện"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
