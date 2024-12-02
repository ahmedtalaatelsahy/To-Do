import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_auth.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/ui/home/home_screen.dart';
import 'package:to_do_app/ui/register/register_screen.dart';

import '../common/text_form_field.dart';
import '../utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'logIn';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004182),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/Group 5.png',
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 11,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Please sign in with your mail',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
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
                    return null;
                  },
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Don’t have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 16)),
                    const SizedBox(
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

  void login() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    signIn();
  }

  void signIn()async{
    var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
    try {
      showLoadingDialog(context, message: 'please wait...');
      final appUser = await authProvider.signInWithEmailAndPassword(
          email.text, password.text);
     Navigator.pop(context);

      if (appUser == null) {
        showMessageDialog(context,
            message: "Something went wrong",
            posButtonTitle: 'try again', posButtonAction: () {
              signIn();
            });
        return;
      }
      showMessageDialog(context, message: "Logged in successfully",
          posButtonTitle: 'ok',
          posButtonAction: (){
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          });
    } on FirebaseAuthException catch (e) {
      String message = 'Something went Wrong';

      if(e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-credential'
      ){
        message = 'Wrong Email or Password';
      }
      Navigator.pop(context);
      showMessageDialog(context, message: message,posButtonTitle: "ok");
    } catch (e) {
      String message = 'Something went Wrong';
      Navigator.pop(context);
      showMessageDialog(context, message: message,posButtonTitle: "try again",
          posButtonAction: (){
            login();
          }
      );

    }
  }
}
