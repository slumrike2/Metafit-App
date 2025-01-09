import 'package:flutter/material.dart';

import 'package:frontmetafit/Components/TextInput.dart';
import 'package:frontmetafit/Components/PasswordRequirement.dart';
import 'package:frontmetafit/const.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Components/ConfirmButton.dart';

class registerPage extends StatefulWidget {
  static const String routeName = '/register';
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  dynamic password;
  String gender = 'M';
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    _fbkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.complementary),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: sizew * 0.025,
          ),
          child: FormBuilder(
            key: _fbkey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyles.headline1(context),
                  ),
                ),
                Textinput(
                  name: 'name',
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                Textinput(
                  name: 'email',
                  hintText: 'Email',
                  labelText: 'Email',
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                Textinput(
                  name: 'password',
                  hintText: 'Password',
                  labelText: 'Password',
                  obscureText: true,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])([A-Za-z\d$@$!%*?&]|[^ ]){8,15}$')
                        .hasMatch(value)) {
                      return 'Password does not meet requirements';
                    }
                    return null;
                  },
                  onchangue: (value) {
                    setState(() {
                      password = value;
                    });

                    return;
                  },
                ),
                Container(
                  padding: EdgeInsets.all(sizew * 0.03),
                  child: Column(
                    children: [
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^.{8,}$'),
                        text: 'At least 8 characters',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^.{0,15}$'),
                        text: 'No more than 15 characters',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^(?=.*[A-Z]).+$'),
                        text: 'At least one uppercase letter',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^(?=.*[a-z]).+$'),
                        text: 'At least one lowercase letter',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^(?=.*\d).+$'),
                        text: 'At least one digit',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^\S+$'),
                        text: 'No whitespace',
                      ),
                      PasswordRequirement(
                        password: password,
                        regex: RegExp(r'^(?=.*[!@#\$&*~]).+$'),
                        text: 'At least one special character',
                      ),
                    ],
                  ),
                ),
                Textinput(
                  name: 'confirmPassword',
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (password != value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onchangue: (value) {
                    _fbkey.currentState!.fields['confirmPassword']!.validate();
                    return;
                  },
                ),
                Container(
                  padding: EdgeInsets.all(sizew * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: sizew * 0.4,
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Date of Birth',
                              style: TextStyle(color: AppColors.complementary),
                            ),
                          ),
                          SizedBox(
                            width: sizew * 0.4,
                            child: FormBuilderDateTimePicker(
                              name: 'date',
                              textAlign: TextAlign.center,
                              inputType: InputType.date,
                              style: TextStyle(color: AppColors.complementary),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.secondary,
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.secondary,
                                    width: 3.0,
                                  ),
                                ),
                                fillColor: AppColors.primaryDark,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: AppColors.complementary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: sizew * 0.4,
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Gender',
                              style: TextStyle(color: AppColors.complementary),
                            ),
                          ),
                          Container(
                            width: sizew * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 3),
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.primaryDark),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      gender = 'M';
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: gender == 'M'
                                        ? AppColors.secondary
                                        : AppColors.primaryDark,
                                  ),
                                  child: Text('M',
                                      style: TextStyle(
                                        color: AppColors.complementary,
                                      )),
                                ),
                                SizedBox(
                                  height: sizeh * 0.055,
                                  child: VerticalDivider(
                                    color: AppColors.secondary,
                                    thickness: 3,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      gender = 'F';
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: gender == 'F'
                                        ? AppColors.secondary
                                        : AppColors.primaryDark,
                                  ),
                                  child: Text('F',
                                      style: TextStyle(
                                        color: AppColors.complementary,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: sizew * 0.45,
                      child: Textinput(
                        hintText: 'Peso',
                        labelText: 'Peso',
                        name: 'peso',
                        suffixText: 'lbs',
                        isNumeric: true,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length > 3) {
                            return 'Value cannot exceed 3 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: sizew * 0.45,
                      child: Textinput(
                        hintText: 'Height',
                        labelText: 'Height',
                        name: 'height',
                        suffixText: 'fts',
                        isNumeric: true,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length > 3) {
                            return 'Value cannot exceed 3 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(sizew * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Goals',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      FormBuilderDropdown(
                        iconEnabledColor: AppColors.complementary,
                        dropdownColor: AppColors.secondary,
                        hint: Text('goals'),
                        focusColor: AppColors.secondary,
                        name: 'goals',
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Lose Weight'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Gain Muscle'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('Maintain Weight'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(sizew * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Experience',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      FormBuilderDropdown(
                        dropdownColor: AppColors.secondary,
                        hint: Text('Experience'),
                        focusColor: AppColors.secondary,
                        name: 'exp',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == '' ||
                              value == '0') {
                            return 'This field is required';
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Lose Weight'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Gain Muscle'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('Maintain Weight'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ConfirmButton(
                  onPressed: () {
                    if (_fbkey.currentState!.saveAndValidate()) {
                      print(_fbkey.currentState!.value);
                    }
                  },
                  text: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verificarPassword() {}
}
