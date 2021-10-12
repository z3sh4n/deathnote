import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/bottom_fields.dart';
import '../Widgets/sheet_button.dart';
import '/constrains/themes.dart';

// ignore: must_be_immutable
class EditNote extends StatefulWidget {
  DocumentSnapshot? docToEdit;
  Map<String, dynamic>? dataa;

  EditNote({Key? key, this.docToEdit, this.dataa}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  TextEditingController _title = TextEditingController();
  TextEditingController _discription = TextEditingController();

  @override
  void initState() {
    _title = TextEditingController(text: widget.docToEdit!['title']);
    _discription =
        TextEditingController(text: widget.docToEdit!['discription']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Edit Note',
          style: TextStyle(color: kBlackColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                widget.docToEdit!.reference
                    .delete()
                    .whenComplete(() => Navigator.of(context).pop());
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[300],
              ))
        ],
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
                  child: field(size, widget.docToEdit!['title'], _title, 1)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: field(
                      size, widget.docToEdit!['discription'], _discription, 3),
                ),
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
                        widget.docToEdit!.reference.update({
                          'title': _title.text,
                          'discription': _discription.text,
                        }).whenComplete(() => Navigator.of(context).pop());
                        // ref
                        //     .doc(_auth.currentUser!.uid)
                        //     .collection('notes')
                        //     .add({
                        //   'title': _title.text,
                        //   'discription': _discription.text,
                        // }).whenComplete(() => Navigator.of(context).pop());
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
