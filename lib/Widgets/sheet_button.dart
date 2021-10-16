// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget button(
  String title,
  IconData icon,
  Color co,
  Function() op,
) {
  return ElevatedButton.icon(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(500)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(co),
          overlayColor: MaterialStateProperty.all(Colors.black26)),
      onPressed: op,
      icon: Icon(
        icon,
        // color: kLightBlackColor,
      ),
      label: Text(
        title,
        // style: TextStyle(color: kLightBlackColor),
      ));
}
