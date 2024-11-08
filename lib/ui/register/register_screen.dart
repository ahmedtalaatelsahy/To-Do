import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_auth.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/ui/home/home_screen.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/utils.dart';

import '../common/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController passwordConfirmation = TextEditingController();

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
                    if ((text?.length)! < 6) {
                      return "password should be at least 6 characters";
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
                    if ((text?.length)! < 6) {
                      return "password should be at least 6 characters";
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
    if (formKey.currentState?.validate() == false) {
      return;
    }
    createAccount();
  }

  void createAccount() async {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context,listen:false);
    try {
      showLoadingDialog(context, message: "please wait...");
      final credential =await authProvider.createUserWithEmailAndPassword(
          email.text, password.text);
      Navigator.pop(context);
      showMessageDialog(
        context,
        message: 'account created successfully',
        posButtonTitle: 'ok',
        posButtonAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      String message = 'something went wrong';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Navigator.pop(context);
      showMessageDialog(context, message: message, posButtonTitle: 'ok');
    } catch (e) {
      String message = 'something went wrong';
      Navigator.pop(context);
      showMessageDialog(
        context,
        message: message,
        posButtonTitle: 'try again',
        posButtonAction: () {
          register();
        },
      );
    }
  }
}
