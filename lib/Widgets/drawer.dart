// ignore_for_file: camel_case_types

import 'package:deathnote/helper/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Screens/home_screen.dart';
import '/Screens/helper_guide_screen.dart';
import '/Screens/term_screen1.dart';
import '/constrains/themes.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(color: kBlackColor),
          Column(
            children: [
              UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: kLightBlackColor.withOpacity(0.15)),
                currentAccountPictureSize: const Size.fromRadius(44.0),
                currentAccountPicture: ClipRRect(
                  child: Image.asset(
                    'assets/images/20211005_172155.jpg',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                accountEmail: Text(
                  _auth.currentUser!.email!,
                  style: const TextStyle(fontSize: 15, color: kWhiteColor),
                ),
                accountName: Text(_auth.currentUser!.displayName!),
              ),
              WidgetList(
                ico: Icons.home_sharp,
                tx: 'Home',
                ot: () {
                  Get.offAll(() => const HomeScreen());
                },
              ),
              WidgetList(
                ico: Icons.help,
                tx: 'helper guide',
                ot: () {
                  Get.to(() => const HelperGuideScreen());
                },
              ),
              WidgetList(
                ico: Icons.info_outline,
                tx: 'terms and Introduction',
                ot: () {
                  Get.to(() => const TermScreen1());
                },
              ),
              const Spacer(),
              WidgetList(
                  ico: Icons.logout_outlined,
                  tx: 'Logout',
                  ot: () => logOut(context)),
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetList extends StatelessWidget {
  final void Function() ot;
  final IconData ico;
  final String tx;
  const WidgetList({
    Key? key,
    required this.ot,
    required this.ico,
    required this.tx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ot,
      leading: Icon(
        ico,
        color: kWhiteColor.withOpacity(0.5),
        size: 25,
      ),
      minLeadingWidth: -40,
      title: Text(
        tx,
        style: const TextStyle(
          color: kWhiteColor,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
