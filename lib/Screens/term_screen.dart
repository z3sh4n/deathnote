import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '/constrains/themes.dart';
import 'auth_screen.dart';

class TermScreen extends StatelessWidget {
  const TermScreen({Key? key}) : super(key: key);

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
                // const SizedBox(height: 60),
                const Text(
                  'Welcome To DeathNote',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                // const SizedBox(height: 155),
                const Text(
                  'Terms/Rules',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 30),
                const Text(
                  'The human whose name is written in this note shall die. This note will not take effect unless the writer has the subjects face in mind when writing his/her name. This is to prevent people who share the same name from being affected.',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                // const SizedBox(height: 50),
                const Text(
                  'No not really i am joking!! Nothing will happen so chill',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                // const SizedBox(height: 200),
                OpenContainer(
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    transitionDuration: const Duration(seconds: 1),
                    closedColor: kLightBlackColor,
                    closedBuilder: (ctx, _) => Container(
                          alignment: Alignment.center,
                          width: 1150,
                          height: 50,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Sign Up/login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         shape: MaterialStateProperty.all(
                    //             RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10))),
                    //         fixedSize:
                    //             MaterialStateProperty.all(const Size(1150, 50)),
                    //         backgroundColor:
                    //             MaterialStateProperty.all(kLightBlackColor)),
                    // child: const Text(
                    //   'Start DEathnote',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // )),
                    openBuilder: (ctx, _) => const AuthScreen()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
