// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '/helper/authenticate.dart';
import '/constrains/themes.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
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
        Column(
          children: [
            IconButton(
                onPressed: () => logOut(context),
                icon: const Icon(Icons.logout)),
          ],
        ),
      ],
    ),
  );
}
