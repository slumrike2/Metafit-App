import 'package:flutter/material.dart';
import 'package:frontmetafit/Components/ConfirmButton.dart';
import 'package:frontmetafit/Pages/Home/Screen.dart';
import 'package:frontmetafit/Pages/Inicio%20de%20seion/forgottenPassword.dart';
import 'package:frontmetafit/Pages/Inicio%20de%20seion/registerPage.dart';
import 'package:frontmetafit/const.dart';
import '/Components/TextInput.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: sizew,
          height: sizeh,
          child: FormBuilder(
            key: _fbkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: sizeh * 0.2,
                      bottom: sizeh * 0.1,
                      left: sizew * 0.1,
                      right: sizew * 0.1),
                  child: Text('Login', style: TextStyles.headline1(context)),
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

                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: sizeh * 0.05),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, forgottenPassword.routeName);
                      },
                      child: Text('Forgot Password?')),
                ),
                !isLoading
                    ? ConfirmButton(
                        onPressed: () async {
                          if (_fbkey.currentState!.saveAndValidate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await supabase.auth.signInWithPassword(
                                  email: _fbkey.currentState!.value['email']
                                      .toString(),
                                  password: _fbkey
                                      .currentState!.value['password']
                                      .toString());
                              Navigator.pushReplacementNamed(
                                  context, Screen.routeName);
                            } catch (e) {
                              if (e is AuthException && e.statusCode == '400') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Invalid credentials'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('An error occurred'),
                                  ),
                                );
                              }
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        text: 'Login',
                      )
                    : CircularProgressIndicator(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, registerPage.routeName);
                          },
                          child: Text('Sign Up')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
