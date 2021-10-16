import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathnote/Widgets/type_chip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/constrains/themes.dart';
import '/Widgets/Sheet_button.dart';
import '/Widgets/bottom_fields.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _title = TextEditingController();

  final TextEditingController _discription = TextEditingController();

  String type = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 500,
        child: Stack(children: [
          Container(color: kWhiteColor),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: field(size, 'Title', _title, 1, kBlackColor),
                  ),
                  const hintx(
                    tx: 'Enter the Type of note here',
                    cx: kBlackColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        TypeChip(
                          tx: 'personal',
                          ic: Icons.info,
                          type: type,
                        ),
                        const SizedBox(width: 10),
                        TypeChip(
                          tx: 'Work',
                          ic: Icons.work,
                          type: type,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 100,
                        child: field(
                            size, 'Discription', _discription, 3, kBlackColor)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const hintx(
                    tx: 'if you want to add reminder press this button or leave as it is',
                    cx: kBlackColor,
                  ),
                  Chip(
                    backgroundColor: kWhiteColor,
                    label: const Text('add reminder '),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        vertical: 3.8, horizontal: 17),
                    labelStyle: const TextStyle(
                      color: kBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: button(
                      'Save',
                      Icons.data_saver_on_sharp,
                      kLightBlackColor,
                      () {
                        print('ddd');
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
                          print('ddssssd');
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}

class hintx extends StatelessWidget {
  final String tx;
  final Color? cx;
  const hintx({
    Key? key,
    this.cx,
    required this.tx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        tx,
        style: TextStyle(fontSize: 8, color: cx),
      ),
    );
  }
}
