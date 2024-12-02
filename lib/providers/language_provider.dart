import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage='English';
 void changeLanguage(String newLanguage){
    currentLanguage = newLanguage;
    notifyListeners();
  }
 String getCurrentLanguage(BuildContext context){
    return currentLanguage=='English'?'English':'العربية';
  }
}