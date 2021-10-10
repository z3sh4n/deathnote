import 'package:flutter/material.dart';

 import '/constrains/themes.dart';

Widget field(
      Size size, String hintText, TextEditingController cont, int? l, bool ep) {
    return SizedBox(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        maxLines: l,
        expands: ep,
        controller: cont,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: kLightBlackColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: kLightBlackColor, width: 2.3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }