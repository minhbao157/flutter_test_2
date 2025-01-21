//Flutter Core Packages
import 'package:flutter/material.dart';

class AuthFiled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  const AuthFiled({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value){
        if(value!.isEmpty){
          return 'Please enter $hintText';
        }
        return null;     
      },
      obscureText: isPassword,
    );
  }  
}
