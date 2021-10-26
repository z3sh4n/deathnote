import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Widgets/new_note.dart';
import '/Widgets/bottom_fields.dart';
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
  String? type;

  @override
  void initState() {
    _title = TextEditingController(text: widget.docToEdit!['title']);
    _discription =
        TextEditingController(text: widget.docToEdit!['discription']);
    type = widget.dataa!['type'];
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
          style: TextStyle(color: kWhiteColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                widget.docToEdit!.reference
                    .delete()
                    .whenComplete(() => Navigator.of(context).pop())
                    .whenComplete(
                      () => Get.snackbar(
                        'Deleted successfully',
                        '',
                        icon: const Icon(Icons.delete, color: Colors.red),
                        backgroundColor: kLightBlackColor.withOpacity(0.3),
                        animationDuration: const Duration(milliseconds: 600),
                        colorText: kWhiteColor,
                        snackPosition: SnackPosition.BOTTOM,
                      ),
                    );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[300],
              ))
        ],
        centerTitle: true,
        backgroundColor: kBlackColor,
      ),
      body: Stack(children: [
        Container(color: kBlackColor),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: field(size, widget.docToEdit!['title'], _title, 1,
                      kWhiteColor)),
              const hintx(
                tx: 'Enter the Type of note here',
                cx: kWhiteColor,
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
                  child: field(size, widget.docToEdit!['discription'],
                      _discription, 3, kWhiteColor),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //  'Chosen date: ${widget.dataa!['redate'] ?? '-'} and time: ${widget.dataa!['retime'] ?? '-'}'
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontFamily: 'DNF',
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      const TextSpan(text: 'chosen date: '),
                      TextSpan(
                          text: widget.dataa!['redate'] ?? '-',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      const TextSpan(text: ' and time: '),
                      TextSpan(
                          text: widget.dataa!['retime'] ?? '-',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(kWhiteColor),
                        overlayColor:
                            MaterialStateProperty.all(Colors.black45)),
                    onPressed: () {
                      if (_title.text.isNotEmpty &&
                          _discription.text.isNotEmpty) {
                        widget.docToEdit!.reference
                            .update({
                              'title': _title.text,
                              'discription': _discription.text,
                              'type': type,
                            })
                            .whenComplete(() => Navigator.of(context).pop())
                            .whenComplete(
                              () => Get.snackbar(
                                'Edited successfully',
                                '',
                                icon:
                                    const Icon(Icons.edit, color: kWhiteColor),
                                backgroundColor:
                                    kLightBlackColor.withOpacity(0.3),
                                animationDuration:
                                    const Duration(milliseconds: 600),
                                colorText: kWhiteColor,
                                snackPosition: SnackPosition.BOTTOM,
                              ),
                            );
                      } else {
                        return;
                      }
                    },
                    icon: const Icon(
                      Icons.data_saver_on_sharp,
                      color: kBlackColor,
                    ),
                    label: const Text(
                      'save',
                      style: TextStyle(color: kBlackColor),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
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
        backgroundColor: kBlackColor,
        label: Row(
          children: [
            Icon(
              ic,
              color: kWhiteColor,
              size: 15,
            ),
            Text(
              tx,
              style: const TextStyle(color: kWhiteColor),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 3,
              color: type == tx ? kLightBlackColor : kBlackColor,
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
