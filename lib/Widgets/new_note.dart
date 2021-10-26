import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/constrains/themes.dart';
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

  DateTime? _selectedDate;

  TimeOfDay? _selectedTime;

  String type = '';

  Future<void>? showDateAndTime() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      currentDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
      // ignore: unnecessary_null_comparison
      if (value != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedTime = value;
          });
        });
      } else {
        return;
      }
    });
  }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: field(size, 'Title', _title, 1, kBlackColor),
              ),
              const hintx(
                tx: 'Select the Type of note here',
                cx: kBlackColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ch(
                      'personal',
                      Icons.info,
                    ),
                    const SizedBox(width: 10),
                    ch(
                      'Work',
                      Icons.work,
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
              _selectedTime != null
                  ? const SizedBox()
                  : const hintx(
                      tx: 'want to add reminder ? press this button',
                      cx: kBlackColor,
                    ),
              InkWell(
                onTap: () {
                  showDateAndTime();
                },
                child: _selectedTime != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: kBlackColor, fontFamily: 'DNF'),
                            children: [
                              const TextSpan(text: 'chosen date: '),
                              TextSpan(
                                  text: DateFormat.yMMMMd()
                                      .format(_selectedDate!),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: ' and time '),
                              TextSpan(
                                  text: _selectedTime!.format(context),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    : Chip(
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
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(kBlackColor),
                        overlayColor:
                            MaterialStateProperty.all(Colors.black45)),
                    onPressed: () {
                      ref.doc(_auth.currentUser!.uid).collection('notes').add({
                        'title': _title.text,
                        'discription': _discription.text,
                        'type': type,
                        'redate': _selectedDate == null
                            ? '-'
                            : DateFormat.yMMMMd().format(_selectedDate!),
                        'retime': _selectedTime == null
                            ? '-'
                            : _selectedTime!.format(context),
                      }).whenComplete(() => Navigator.of(context).pop());
                    },
                    icon: const Icon(
                      Icons.data_saver_on_sharp,
                    ),
                    label: const Text(
                      'save',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget ch(String tx, IconData ic) {
    return InkWell(
      onTap: () {
        setState(() {
          type = tx;
        });
      },
      child: Chip(
        backgroundColor: kWhiteColor,
        label: Row(
          children: [
            Icon(
              ic,
              size: 15,
            ),
            Text(tx),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 3,
              color: type == tx ? kLightBlackColor : Colors.transparent,
            )),
        labelPadding: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 17),
        labelStyle: const TextStyle(
          color: kBlackColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
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
