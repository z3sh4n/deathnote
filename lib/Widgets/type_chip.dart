import 'package:deathnote/constrains/themes.dart';
import 'package:flutter/material.dart';

class TypeChip extends StatefulWidget {
  String tx;
  String type;
  IconData ic;
  TypeChip({Key? key, required this.tx, required this.type, required this.ic})
      : super(key: key);

  @override
  _TypeChipState createState() => _TypeChipState();
}

class _TypeChipState extends State<TypeChip> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.type = widget.tx;
        });
      },
      child: Chip(
        backgroundColor: kWhiteColor,
        label: Row(
          children: [
            Icon(
              widget.ic,
              size: 15,
            ),
            Text(widget.tx),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 3,
              color: widget.type == widget.tx
                  ? kLightBlackColor
                  : Colors.transparent,
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
