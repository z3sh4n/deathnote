import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
          const EdgeInsets.only(
            bottom: 30,
          ),
        )),
        child: Text(
          data!['title'],
        ),
        onPressed: () {});
  }
}
