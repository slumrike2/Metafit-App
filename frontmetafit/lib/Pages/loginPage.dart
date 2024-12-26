import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Pages/forgottenPassword.dart';
import 'package:frontmetafit/Pages/registerPage.dart';
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
              Text('Login', style: textstyles.headline1),
              Textinput(
                name: 'email',
                hintText: 'Email',
                labelText: 'Email',
              ),
              Textinput(
                name: 'password',
                hintText: 'Password',
                labelText: 'Password',
                obscureText: true,
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
