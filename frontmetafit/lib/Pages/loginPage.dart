import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Pages/Inicio%20de%20seion/forgottenPassword.dart';
import 'package:frontmetafit/Pages/Inicio%20de%20seion/registerPage.dart';
import 'package:frontmetafit/const.dart';
import '/Components/TextInput.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: sizew,
        height: sizeh,
        child: FormBuilder(
          key: _fbkey,
          child: Column(
            children: [
              Text('Login', style: TextStyles.headline1(context)),
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

                  return null;
                },
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, forgottenPassword.routeName);
                    },
                    child: Text('Forgot Password?')),
              ),
              ConfirmButton(
                onPressed: () {
                  if (_fbkey.currentState!.saveAndValidate()) {
                    print(_fbkey.currentState!.value);
                  }
                },
                text: 'Login',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  Container(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, registerPage.routeName);
                        },
                        child: Text('Sign Up')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
