import 'package:flutter/material.dart';
import 'package:management_tugas/widget/text_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../assets.dart';

class Categori extends StatelessWidget {
  final String name;
  final int task;
  final double value;
  final Function() tekanTombol;
  final bool border;
  const Categori({
    required this.value,
    required this.name,
    required this.task,
    required this.border,
    required this.tekanTombol,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 100.5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(11.5, 20, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.5),
              child: TextWidget(
                text: "$task task",
                color: second,
                size: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                splashColor: primer,
                onTap: tekanTombol,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.5),
                  child: TextWidget(
                    size: 20,
                    color: primer,
                    fontWeight: FontWeight.w800,
                    text: "$name >",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            LinearPercentIndicator(
              animation: true,
              lineHeight: 4,
              animationDuration: 500,
              percent: value,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.greenAccent,
              padding: const EdgeInsets.symmetric(horizontal: 5.5),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: primer,
              width: 1.5,
              style: border == true ? BorderStyle.solid : BorderStyle.none),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0.5, 8),
            )
          ]),
    );
  }
}
