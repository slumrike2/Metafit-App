import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontmetafit/const.dart';
import 'package:flutter/services.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Textinput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String name;
  final bool obscureText;
  final String? Function(String?)? validation;
  final String? Function(String?)? onchangue;
  String? suffixText;
  final bool isNumeric;

  Textinput({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.name,
    this.obscureText = false,
    this.validation,
    this.onchangue,
    this.suffixText = '',
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, bottom: 5),
            child: Text(labelText,
                style: TextStyle(
                  color: AppColors.complementary,
                )),
          ),
          FormBuilderTextField(
            obscureText: obscureText,
            name: name,
            style: TextStyle(
              color: AppColors.complementary,
            ),
            validator: (value) {
              if (validation != null) {
                return validation!(value);
              }
              return null;
            },
            onChanged: onchangue,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 3,
                    color: AppColors.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.secondary,
                    width: 3.0,
                  ),
                ),
                filled: true,
                fillColor: AppColors.primaryDark,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.tertiary,
                ),
                suffixIcon: Container(
                  alignment: Alignment.center,
                  width: 40, // Adjust the width as needed
                  child: Text(suffixText!),
                ),
                suffixStyle: TextStyle(
                  color: AppColors.complementary,
                )),
          ),
        ],
      ),
    );
  }
}
