import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/core/common/widgets/loader.dart';
import 'package:namer_app/core/theme/app_pallete.dart';
import 'package:namer_app/core/utils/pick_image.dart';
import 'package:namer_app/core/utils/show_snackbar.dart';
import 'package:namer_app/features/Home/presentation/pages/home_page.dart';
import 'package:namer_app/features/Home/presentation/pond/pond_bloc.dart';
import 'package:namer_app/features/Home/presentation/widgets/pond_editor.dart';
import 'package:namer_app/features/auth/presentation/cubits/app_user/app_user_cubit.dart';

class AddNewPondPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewPondPage(),
      );
  const AddNewPondPage({super.key});

  @override
  State<AddNewPondPage> createState() => _AddNewPondPageState();
}

class _AddNewPondPageState extends State<AddNewPondPage> {
  final nameController = TextEditingController();
  final areaController = TextEditingController();
  final deepController = TextEditingController();
  final costsController = TextEditingController();
  final activeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage(ImageSource source) async {
    final pickedImage = await pickImage(source);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Chụp ảnh bằng Camera'),
            onTap: () {
              context.pop();
              selectImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Chọn từ Thư viện'),
            onTap: () {
              context.pop();
              selectImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void uploadPond() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<PondBloc>().add(
            PondUpload(
              userID: userId,
              name: nameController.text.trim(),
              area: int.parse(areaController.text.trim()),
              deep: int.parse(deepController.text.trim()),
              costs: int.parse(costsController.text.trim()),
              active: int.parse(activeController.text.trim()),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    areaController.dispose();
    deepController.dispose();
    costsController.dispose();
    activeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Ao'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              uploadPond();
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: BlocConsumer<PondBloc, PondState>(
        listener: (context, state) {
          if(state is PondFailure){
            showSanckBar(context, state.error);
          }else if(state is PondUploadSuccess){
            Navigator.pushAndRemoveUntil(
              context, 
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if(state is PondLoading){
            return const Loader();
          }
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: showImagePickerModal,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : DottedBorder(
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Chọn ảnh của bạn',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Ao nuôi',
                          'Ao xử lý nước',
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.clear();
                                        selectedTopics.add(e);
                                      }
                                    });
                                  },
                                  child: Chip(
                                    label: SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: Text(e),
                                      ),
                                    ),
                                    backgroundColor: selectedTopics.contains(e)
                                        ? const Color.fromARGB(
                                            255, 140, 217, 255)
                                        : null,
                                    side: selectedTopics.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: AppPallete.borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    PondEditor(
                      controller: nameController,
                      hintText: 'Nhập tên ao (1 đến 20 kí tự)',
                      validatorMessage: 'Vui lòng nhập tên ao',
                      isNumberic: false,
                    ),
                    const SizedBox(height: 15),
                    PondEditor(
                      controller: areaController,
                      hintText: 'Nhập diện tích (m\u00B2)',
                      validatorMessage: 'Vui lòng nhập diện tích',
                      isNumberic: true,
                    ),
                    const SizedBox(height: 15),
                    PondEditor(
                      controller: deepController,
                      hintText: 'Độ sâu ao (m)',
                      validatorMessage: 'Vui lòng nhập độ sâu ao',
                      isNumberic: true,
                    ),
                    const SizedBox(height: 15),
                    PondEditor(
                      controller: costsController,
                      hintText: 'Chi phí tạo ao (đ)',
                      validatorMessage: 'Vui lòng nhập chi phí',
                      isNumberic: true,
                    ),
                    const SizedBox(height: 15),
                    PondEditor(
                      controller: activeController,
                      hintText: 'Số vụ nuôi có thể sử dụng',
                      validatorMessage: 'Vui lòng nhập số vụ nuôi',
                      isNumberic: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
