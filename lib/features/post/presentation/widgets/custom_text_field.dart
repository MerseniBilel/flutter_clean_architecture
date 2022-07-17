import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  const CustomFormField(
      {Key? key,
      required this.controller,
      this.hint,
      this.validator,
      this.minLines,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(hintText: hint),
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}
