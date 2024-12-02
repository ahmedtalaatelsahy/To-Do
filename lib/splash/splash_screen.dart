import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/ui/home/home_screen.dart';

import '../ui/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        authProvider.isLoggedIn()
            ? Navigator.pushReplacementNamed(context, HomeScreen.routeName)
            : Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
    return Scaffold(
        body: Center(
            child: themeProvider.isDarkEnabled()
                ? Image.asset('assets/images/dark_splash.png')
                : Image.asset('assets/images/splash_background.png')));
  }
}
