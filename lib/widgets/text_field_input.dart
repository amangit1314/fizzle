import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon? icon;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      style: const TextStyle(
        color: Colors.white,
        // font size body small
        fontSize: 14,
      ),
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        filled: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
