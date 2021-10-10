import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/constrains/themes.dart';
import 'Sheet_button.dart';
import 'bottom_fields.dart';


class NewNote extends StatelessWidget {
  NewNote({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference ref = FirebaseFirestore.instance.collection('users');

  final TextEditingController _title = TextEditingController();
  final TextEditingController _discription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: field(size, 'Title', _title, 1, false),
              ),
              Expanded(
                  child: field(size, 'Discription', _discription, null, true)),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  button('alarm', Icons.add_alarm_outlined, kLightBlackColor,
                      () {})
                ],
              ),
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
                              }).whenComplete(
                                      () => Navigator.of(context).pop());
                            } else {
                              return null;
                            }
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
