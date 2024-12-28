import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/TextDropDownInput.dart';
import 'package:frontmetafit/Components/TextInput.dart';
import 'package:frontmetafit/Components/PasswordRequirement.dart';
import 'package:frontmetafit/const.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Components/ConfirmButton.dart';

class registerPage extends StatefulWidget {
  static const String routeName = '/register';
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  dynamic password;
  String gender = 'M';
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

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
                  margin: EdgeInsets.symmetric(
                    vertical: sizeh * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
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
                            Container(
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
                ),
                Container(
                  width: sizew * 0.9,
                  height: sizeh * 0.1,
                  child: Textdropdowninput(
                      label: 'Peso',
                      nameText: 'peso',
                      nameDropdown: 'medida',
                      hintText: 'Peso',
                      items: ['KG', 'LB'],
                      onChanged: (value) {
                        print(value);
                      }),
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
