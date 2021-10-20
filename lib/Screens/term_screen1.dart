// ignore_for_file: unnecessary_null_comparison

import 'package:deathnote/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constrains/themes.dart';

class TermScreen1 extends StatelessWidget {
  const TermScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: kBlackColor),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  'Welcome To DeathNote',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Terms/Rules',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'The human whose name is written in this note shall die. This note will not take effect unless the writer has the subjects face in mind when writing his/her name. This is to prevent people who share the same name from being affected.',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                const Text(
                  'No not really i am just kidding!! Nothing will happen so chill',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(() => const HomeScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBlackColor.withOpacity(0.8),
                    ),
                    alignment: Alignment.center,
                    width: 1150,
                    height: 50,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "lets get started",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
