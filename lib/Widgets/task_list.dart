import 'package:deathnote/constrains/themes.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final Map<String, dynamic>? data;
  const TaskList({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: _w,
      child: Row(
        children: [
          // Theme(
          //     data: ThemeData(
          //         primarySwatch: Colors.blue,
          //         unselectedWidgetColor: kLightBlackColor),
          //     child: Transform.scale(
          //         child: Checkbox(
          //           activeColor: kWhiteColor,
          //           checkColor: kLightBlackColor,
          //           value: true,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5)),
          //           onChanged: (bool? value) {},
          //         ),
          //         scale: 1.5)),
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
                    child: const Icon(Icons.work),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data!['title'],
                          maxLines: 1,
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
                          data!['discription'],
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 9,
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
