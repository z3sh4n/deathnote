import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathnote/Screens/edit_note_screen.dart';
import 'package:deathnote/Widgets/home_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'new_note_screen.dart';
import '/constrains/themes.dart';
import '/Widgets/cusAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int columnCount = 2;

  final ref = FirebaseFirestore.instance.collection('users');
  late final Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
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
                        child: CircularProgressIndicator(
                          color: kWhiteColor,
                        ),
                      );
                    }

                    return AnimationLimiter(
                      key: UniqueKey(),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, i) {
                          Map<String, dynamic>? data = snapshot.data!.docs[i]
                              .data() as Map<String, dynamic>?;
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
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
                                        closedBuilder: (context, _) => HomeGrid(
                                              data: data,
                                            ),
                                        openBuilder: (ctx, _) => EditNote(
                                              docToEdit: snapshot.data!.docs[i],
                                              dataa: data,
                                            ))
                                    //  HomeGrid(
                                    //   data: data,
                                    // ),
                                    )
                                // Container(
                                //   child: Column(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.start,
                                //     children: [
                                //       Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text(data!['title'],
                                //             style: const TextStyle(
                                //                 color: Colors.white,
                                //                 fontWeight: FontWeight.bold)),
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Text(data['discription'],
                                //             textAlign: TextAlign.right,
                                //             style: const TextStyle(
                                //               color: Colors.white60,
                                //             )),
                                //       ),
                                //     ],
                                //   ),
                                // margin: EdgeInsets.only(
                                //   bottom: _w / 30,
                                // ),
                                //   decoration: const BoxDecoration(
                                //     color: kLightBlackColor,
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(20)),
                                //   ),
                                // ),
                                ),
                          );
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
        floatingActionButton: OpenContainer(
            openColor: kLightBlackColor,
            middleColor: kLightBlackColor,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            openShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            closedColor: kWhiteColor,
            transitionDuration: const Duration(milliseconds: 700),
            closedBuilder: (context, _) => const Icon(
                  Icons.add,
                  size: 50,
                ),
            openBuilder: (ctx, _) => NewNote()));
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
