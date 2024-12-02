import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/providers/language_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/splash/splash_screen.dart';
import 'package:to_do_app/ui/home/home_screen.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/register/register_screen.dart';
import 'package:to_do_app/ui/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AppAuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => TasksProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
    ),ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          RegisterScreen.routeName: (_) => const RegisterScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          SplashScreen.routeName: (_) => const SplashScreen()
        },
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode:
            themeProvider.currentTheme);
  }
}
