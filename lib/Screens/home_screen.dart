import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '/constrains/themes.dart';
import '/Screens/404_error_screen.dart';
import '/Screens/edit_note_screen.dart';
import '/Widgets/drawer.dart';
import '/Widgets/new_note.dart';
import '/Widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ref = FirebaseFirestore.instance.collection('users');

  late final Map<String, dynamic> userMap;

  @override
  void initState() {
    super.initState();
    checkconnect();
  }

  void checkconnect() async {
    var con = await (Connectivity().checkConnectivity());
    if (con == ConnectivityResult.none) {
      Get.offAll(() => const ErrorScreen());
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: drawer(auth: _auth),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: kBlackColor,
            title: const Text('DEathnote'),
          ),
          body: Stack(
            children: [
              Container(color: kBlackColor),
              AnimationLimiter(
                  key: UniqueKey(),
                  child: StreamBuilder(
                    stream: ref
                        .doc(_auth.currentUser!.uid)
                        .collection('notes')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('SomeThing went Wrong'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        const Center(
                          child: CircularProgressIndicator(
                            color: kWhiteColor,
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'NO Data found try to add some',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        );
                      }

                      return AnimationLimiter(
                        key: UniqueKey(),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            Map<String, dynamic>? data = snapshot.data!.docs[i]
                                .data() as Map<String, dynamic>?;
                            checkconnect();
                            return AnimationConfiguration.staggeredList(
                              position: i,
                              duration: const Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                    child: OpenContainer(
                                        openColor: kLightBlackColor,
                                        middleColor: kLightBlackColor,
                                        closedShape:
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        openShape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        closedColor: kBlackColor,
                                        closedElevation: 0,
                                        openElevation: 0,
                                        transitionDuration:
                                            const Duration(milliseconds: 700),
                                        closedBuilder: (context, _) => TaskList(
                                              data: data,
                                            ),
                                        openBuilder: (ctx, _) => EditNote(
                                              docToEdit: snapshot.data!.docs[i],
                                              dataa: data,
                                            ))),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _startNote(context, const NewNote()),
            child: const Icon(
              Icons.add,
              color: kBlackColor,
              size: 50,
            ),
          )),
    );
  }

  void _startNote(BuildContext ctx, Widget w) {
    showModalBottomSheet(
        backgroundColor: kWhiteColor,
        context: ctx,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        isScrollControlled: true,
        enableDrag: true,
        builder: (_) {
          return GestureDetector(
            child: w,
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
}
