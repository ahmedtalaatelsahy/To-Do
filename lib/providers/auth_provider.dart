import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/dataBase/collection/user_collection.dart';
import 'package:to_do_app/dataBase/model/app_user.dart';

class AppAuthProvider extends ChangeNotifier {
  User? authUser;
  AppUser? appUser;
  UserCollection usersCollection = UserCollection();
  AppAuthProvider() {
    authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      appUser = AppUser(authId: authUser?.uid, email: authUser?.email);
    }
  }
  bool isLoggedIn() {
    return authUser != null && appUser != null;
  }

  void login(User newUser) {
    authUser = newUser;
    appUser = AppUser(authId: authUser?.uid, email: authUser?.email);
    notifyListeners();
  }

  void logout() {
    authUser = null;
    appUser = null;
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<AppUser?> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      login(credential.user!);
      // insert user to fire store
      appUser = AppUser(
          authId: credential.user?.uid, fullName: fullName, email: email);
      var result = await usersCollection
          .createUser(appUser!); // check if user created or there is an error
      return appUser!;
    }
    return null;
  }

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      login(credential.user!);
      appUser = await usersCollection.readUser(credential.user!.uid);
    }
    return appUser;
  }
}
