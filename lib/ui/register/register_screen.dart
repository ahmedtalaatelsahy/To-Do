import 'package:flutter/material.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/utils.dart';

import '../common/text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});

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
                AppFormField(
                  title: 'Full Name',
                  hint: 'enter your full name',
                  keyboardType: TextInputType.name,
                  controller: fullName,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return 'please enter full name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                AppFormField(
                  title: 'Password Confirmation',
                  hint: 'enter password again to confirm',
                  keyboardType: TextInputType.visiblePassword,
                  isPasswordSecure: true,
                  controller: passwordConfirmation,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return "please enter password";
                    }
                    if ((text?.length)! < 8) {
                      return "password should be at least 8 characters";
                    }
                    if (password.text != text) {
                      return "password doesn't match";
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
                      "Sign up",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Already have account?',
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
                            context, LoginScreen.routeName);
                      },
                      child: Text(
                        'Login',
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
