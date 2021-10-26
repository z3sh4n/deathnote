import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '/constrains/themes.dart';
import 'helper/authenticate.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeathNote',
      theme: ThemeData(
        fontFamily: 'DNF',
        primaryColor: kLightBlackColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kWhiteColor),
      ),
      home: Authenticate(),
    );
  }
}
