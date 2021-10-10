import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/Widgets/new_note.dart';
import '/helper/authenticate.dart';
import '/constrains/themes.dart';

class Homereen extends StatefulWidget {
  const Homereen({Key? key}) : super(key: key);

  @override
  State<Homereen> createState() => _HomereenState();
}

class _HomereenState extends State<Homereen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _startAddNewNote(BuildContext ctx) {
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
            child: NewNote(),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  int columnCount = 2;

  final ref = FirebaseFirestore.instance.collection('users');
  late final Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kBlackColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/20211005_172155.jpg',
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const Text('DEathnote'),
              IconButton(
                  onPressed: () => logOut(context),
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(color: kBlackColor),
            StreamBuilder(
              stream: ref
                  .doc(_auth.currentUser!.uid)
                  .collection('notes')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, i) {
                        Map<String, dynamic>? map = snapshot.data!.docs[i]
                            .data() as Map<String, dynamic>?;
                        return cc(map!);
                      });
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 00,
            onPressed: () => _startAddNewNote(context),
            backgroundColor: kWhiteColor,
            child: const Icon(
              Icons.add,
              size: 40,
              color: kBlackColor,
            )));
  }

  Widget cc(Map<String, dynamic> map) {
    return Text(
      map['title'],
      style: const TextStyle(color: kWhiteColor, fontSize: 80),
    );
  }
}
// // GridView.count(
                  // physics: const BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  // padding: EdgeInsets.all(_w / 60),
// //                   crossAxisCount: columnCount,
// //                   children: snapshot.data!.docs.map(
// //                     (DocumentSnapshot document) {
// //                       print('dd');
// //                       Map<String, dynamic> data =
// //                           document.data()! as Map<String, dynamic>;
// //                       return AnimationConfiguration.staggeredGrid(
// //                         position: snapshot.data!.docs.length,
// //                         duration: const Duration(milliseconds: 500),
// //                         columnCount: columnCount,
// //                         child: ScaleAnimation(
                          // duration: const Duration(milliseconds: 900),
                          // curve: Curves.fastLinearToSlowEaseIn,
// //                           child: FadeInAnimation(
// //                             child:


// ListTile(
//                                       isThreeLine: true,
//                                       leading: const CircleAvatar(
//                                           child: Icon(
//                                             Icons.info_outline,
//                                             color: kWhiteColor,
//                                           ),
//                                           backgroundColor: kLightBlackColor),
//                                       title: Text(data!['title'],
//                                           style: const TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold)),
//                                       subtitle: Text(data['discription'],
//                                           style: const TextStyle(
//                                             color: Colors.white30,
//                                           )),
//                                       trailing: const Text(
//                                         '02/22/21',
//                                         style: TextStyle(color: Colors.white60),
//                                       ),
//                                       minVerticalPadding: 10,
//                                       tileColor: kLightBlackColor,
//                                       onTap: () {
//                                         _startNote(
//                                             context,
//                                             EditNote(
//                                                 docToEdit:
//                                                     snapshot.data!.docs[i]));
//                                       },
//                                     ),