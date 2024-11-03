import 'package:flutter/material.dart';
import 'package:to_do_app/ui/home/home_screen.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/register/register_screen.dart';
import 'package:to_do_app/ui/style/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          RegisterScreen.routeName:(_)=>RegisterScreen(),
          LoginScreen.routeName:(_)=>LoginScreen()
        },
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: ThemeMode.light);
  }
}
