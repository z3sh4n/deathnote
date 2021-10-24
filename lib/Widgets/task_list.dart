import 'package:flutter/material.dart';

import '/constrains/themes.dart';

class TaskList extends StatelessWidget {
  final Map<String, dynamic>? data;
  const TaskList({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    // ignore: unused_local_variable
    IconData ic;
    switch (data!['type']) {
      case 'Work':
        ic = Icons.work;
        break;
      case 'personal':
        ic = Icons.info;
        break;
      default:
        ic = Icons.work;
    }

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
                    value: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (bool? value) {
                      value = true;
                    },
                  ),
                  scale: 1.5)),
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
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(ic),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          data!['title'],
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data!['discription'],
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
                  const Expanded(
                    flex: 1,
                    child: Text(
                      '10 AM',
                      style: TextStyle(
                        fontSize: 11,
                        color: kWhiteColor,
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
