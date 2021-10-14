import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathnote/Widgets/new_note.dart';
import 'package:deathnote/Widgets/type_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  String type = '';

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
                        icon: Icon(Icons.delete, color: Colors.red[300]),
                        backgroundColor: kLightBlackColor,
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
                  child: field(size, widget.docToEdit!['title'], _title, 1)),
              const hintx(
                tx: 'Enter the Type of note here',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TypeChip(
                      tx: 'personal',
                      type: type,
                    ),
                    const SizedBox(width: 10),
                    TypeChip(
                      tx: 'Work',
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
                      size, widget.docToEdit!['discription'], _discription, 3),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Chip(
                backgroundColor: kWhiteColor,
                label: const Text('add reminder '),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelPadding:
                    const EdgeInsets.symmetric(vertical: 3.8, horizontal: 17),
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
                  kBlackColor,
                  () {
                    if (_title.text.isNotEmpty &&
                        _discription.text.isNotEmpty) {
                      widget.docToEdit!.reference
                          .update({
                            'title': _title.text,
                            'discription': _discription.text,
                          })
                          .whenComplete(() => Navigator.of(context).pop())
                          .whenComplete(
                            () => Get.snackbar(
                              'Edited successfully',
                              '',
                              icon: const Icon(Icons.edit, color: kWhiteColor),
                              backgroundColor: kLightBlackColor,
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              colorText: kWhiteColor,
                              snackPosition: SnackPosition.BOTTOM,
                            ),
                          );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
