// ignore_for_file: avoid_print, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/Screens/home_screen.dart';
import '/constrains/themes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLogin(
      hideForgotPasswordButton: true,
      onSignup: handleSignnup,
      onLogin: handleLogin,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Get.offAll(const HomeScreen());
      },
      theme: LoginTheme(
          pageColorDark: kBlackColor,
          primaryColor: kBlackColor,
          footerBackgroundColor: kBlackColor,
          pageColorLight: kBlackColor,
          accentColor: kBlackColor,
          switchAuthTextColor: kBlackColor,
          buttonTheme: const LoginButtonTheme(
            splashColor: kLightBlackColor,
          )),
    ));
  }
}

Duration get loginTime => const Duration(milliseconds: 1000);

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String?> handleSignnup(LoginData lg) async {
  try {
    final user = await _auth.createUserWithEmailAndPassword(
        email: lg.name, password: lg.password);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "email": lg.name,
      "uid": _auth.currentUser!.uid,
    });
    return user != null ? null : 'Cannot log user in';
  } catch (e) {
    return null;
  }
}

Future<String?> handleLogin(LoginData lg) async {
  try {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: lg.name, password: lg.password);

    _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return user != null ? null : 'Cannot log user in';
  } catch (e) {
    return null;
  }
}

const users = {
  'xx@x.com': '12345',
  'hunter@gmail.com': 'hunter',
};
Future<String> _recoverPassword(String name) {
  print('Name: $name');
  return Future.delayed(loginTime).then((_) {
    if (!users.containsKey(name)) {
      return 'Username not exists';
    }
    return '';
  });
}
