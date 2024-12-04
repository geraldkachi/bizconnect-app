import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines; // Optional: to adjust how many lines the textarea can expand to
  final int? minLines; // Optional: to set the minimum height of the textarea

  const InputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 5,  // Default max lines to 5, but can be adjusted
    this.minLines = 1,  // Default min lines to 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 7),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          maxLines: maxLines, // Adjust how many lines the input field can have
          minLines: minLines, // Adjust the minimum number of lines (height)
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: grey100,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: grey100,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 10.0,
              color: grey400,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: suffixIcon,
            prefixIcon:prefixIcon 
          ),
        ),
      ],
    );
  }
}
