import 'package:Postly/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final String hint;
  final String? Function(String?) validator;
  final int maxLines;
  final TextInputAction inputAction;

  const InputField({
    Key? key,
    required this.controller,
    required this.maxLength,
    required this.hint,
    required this.validator,
    required this.inputAction,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hint,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PostlyColors.bundlePurple,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PostlyColors.bundlePurple,
          ),
        ),
      ),
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      textInputAction: inputAction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }
}
