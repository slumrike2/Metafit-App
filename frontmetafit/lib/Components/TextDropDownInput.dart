import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Textdropdowninput extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? value;
  final String? errorText;
  final String nameText;
  final String nameDropdown;
  final String? Function(String?)? validation;
  final String label;

  const Textdropdowninput({
    super.key,
    required this.label,
    required this.nameText,
    required this.nameDropdown,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.errorText,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          name: nameText,
          validator: validation,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
          ),
        ),
        FormBuilderDropdown(
          name: nameDropdown,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
