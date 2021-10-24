import 'package:flutter/material.dart';

import '/constrains/themes.dart';

class TaskList extends StatefulWidget {
  final Map<String, dynamic>? data;
  const TaskList({Key? key, this.data}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    // ignore: unused_local_variable
    IconData ic;
    switch (widget.data!['type']) {
      case 'Work':
        ic = Icons.work;
        break;
      case 'personal':
        ic = Icons.info;
        break;
      default:
        ic = Icons.work;
    }

    bool? val = false;

    return SizedBox(
      width: _w,
      child: Row(
        children: [
          Theme(
              data: ThemeData(
                  primarySwatch: Colors.blue,
                  unselectedWidgetColor: kLightBlackColor),
              child: Transform.scale(
                  child: Checkbox(
                    activeColor: kWhiteColor,
                    checkColor: kLightBlackColor,
                    value: val,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (bool? value) {
                      setState(() {
                        val = value;
                      });
                    },
                  ),
                  scale: 1.2)),
          Expanded(
              child: SizedBox(
            height: 75,
            child: Card(
              color: kLightBlackColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 33,
                    width: 36,
                    decoration: BoxDecoration(
                        color: kWhiteColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(ic),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          widget.data!['title'],
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.data!['discription'],
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                              overflow: TextOverflow.ellipsis,
                              color: kWhiteColor.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      widget.data!['retime'] ?? '',
                      maxLines: 1,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 9,
                        color: kWhiteColor,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
