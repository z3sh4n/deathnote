import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/constrains/themes.dart';
import '../Widgets/Sheet_button.dart';
import '../Widgets/bottom_fields.dart';

class NewNote extends StatelessWidget {
  NewNote({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _title = TextEditingController();
  final TextEditingController _discription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'add new Note',
            style: TextStyle(color: kBlackColor),
          ),
          centerTitle: true,
          backgroundColor: kWhiteColor,
        ),
        body: Stack(children: [
          Container(color: kWhiteColor),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: field(size, 'Title', _title, 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 100,
                      child: field(size, 'Discription', _discription, 3)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: const Text('TODo Make bool'),
                  color: kBlackColor,
                  height: 50,
                  width: double.infinity,
                ),
                button(
                    'alarm', Icons.add_alarm_outlined, kLightBlackColor, () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    button(
                      'Save',
                      Icons.data_saver_on_sharp,
                      kBlackColor,
                      () {
                        if (_title.text.isNotEmpty &&
                            _discription.text.isNotEmpty) {
                          ref
                              .doc(_auth.currentUser!.uid)
                              .collection('notes')
                              .add({
                            'title': _title.text,
                            'discription': _discription.text,
                          }).whenComplete(() => Navigator.of(context).pop());
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ]));
  }
}
