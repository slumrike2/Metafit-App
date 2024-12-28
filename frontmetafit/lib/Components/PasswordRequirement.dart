import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class PasswordRequirement extends StatelessWidget {
  final String? password;
  final RegExp regex;
  final String text;

  const PasswordRequirement({
    super.key,
    this.password,
    required this.regex,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return password == null || !regex.hasMatch(password ?? '')
        ? Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(color: AppColors.tertiary),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
