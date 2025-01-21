//Flutter Package
import 'package:flutter/material.dart';

void showSanckBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}