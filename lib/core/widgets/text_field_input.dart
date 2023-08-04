import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon? icon;
   final Icon? suffixIcon;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.icon, this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      style: const TextStyle(
        color: Colors.white,
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
        // suffix icon 
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(15),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
