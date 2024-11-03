import 'package:flutter/material.dart';
import 'package:to_do_app/ui/register/register_screen.dart';

import '../common/text_form_field.dart';
import '../utils.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'logIn';
  LoginScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004182),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/Group 5.png',
                  width: double.infinity,
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Please sign in with your mail',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 20,
                ),
                AppFormField(
                  title: 'E-mail address',
                  hint: 'enter your email address',
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return "please enter your email";
                    }
                    if (!validatorUtils.isValidEmail(text!)) {
                      return "please enter valid email";
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                AppFormField(
                  title: 'Password',
                  hint: 'enter your password',
                  keyboardType: TextInputType.visiblePassword,
                  isPasswordSecure: true,
                  controller: password,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return "please enter password";
                    }
                    if ((text?.length)! < 8) {
                      return "password should be at least 8 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Don’t have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 16)),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    formKey.currentState?.validate();
  }
}
