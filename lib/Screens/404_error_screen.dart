// ignore_for_file: file_names
import 'package:connectivity/connectivity.dart';
import 'package:deathnote/constrains/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool isL = false;

  @override
  void initState() {
    super.initState();
    checkconnect();
  }

  void checkconnect() async {
    setState(() {
      isL = true;
    });
    var con = await (Connectivity().checkConnectivity());
    if (con == ConnectivityResult.mobile) {
      Get.offAll(() => const HomeScreen());
    } else if (con == ConnectivityResult.wifi) {
      Get.offAll(() => const HomeScreen());
    }
    setState(() {
      isL = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.thumb_up_off_alt_rounded),
          elevation: 0,
          centerTitle: true,
          backgroundColor: kBlackColor,
          title: const Text('DEathnote'),
        ),
        body: Stack(
          children: [
            Container(
              color: kBlackColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'No internet connction please turn on your mobile data or wifi',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kWhiteColor, fontSize: 16),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: checkconnect,
                  child: Chip(
                    backgroundColor: kWhiteColor,
                    label: isL
                        ? const CircularProgressIndicator(color: kBlackColor)
                        : const Text('retry'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 17),
                    labelStyle: const TextStyle(
                      color: kBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: checkconnect,
          child: const Icon(
            Icons.add,
            color: kBlackColor,
            size: 50,
          ),
        ));
  }
}
