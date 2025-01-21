import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PondEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isNumberic;
  final String validatorMessage;

  const PondEditor({
    super.key, 
    required this.controller, 
    required this.hintText,
    required this.isNumberic,
    required this.validatorMessage,  
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
      validator: (value){
        if(value!.isEmpty){
          return validatorMessage;
        }
        return null;
      },
      keyboardType: isNumberic ? TextInputType.number : TextInputType.text, 
      inputFormatters : isNumberic
      ? [FilteringTextInputFormatter.digitsOnly]
      : [],
    );
  }
}