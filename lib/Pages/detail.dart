import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:management_tugas/widget/text_widget.dart';

import '../assets.dart';

class Detail extends StatefulWidget {
  final String jurusan, deadline, kelas, catatan;
  const Detail({
    Key? key,
    required this.jurusan,
    required this.deadline,
    required this.kelas,
    required this.catatan,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  late QuillController _controller;
  Future<void> _loadFromAssets() async {
    try {
      final doc = Document.fromJson(jsonDecode(widget.catatan));
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      final doc = Document()..insert(0, "is Empty");
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: primer),
        title: TextWidget(
          size: 22,
          color: primer,
          fontWeight: FontWeight.bold,
          text: "Detail",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.menu_open),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: tinggi / 30,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: TextWidget(
                  text: "${widget.jurusan}",
                  size: 16,
                  overflow: TextOverflow.ellipsis,
                  color: primer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          LineWiget(),
          Container(
            height: tinggi / 23,
            child: CountdownTimer(
              endTime: DateTime.parse(widget.deadline).millisecondsSinceEpoch,
              widgetBuilder: (_, time) {
                if (time == null) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.av_timer),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: tinggi / 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: TextWidget(
                          text: "Waktunya habis",
                          size: 16,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                }
                if (time.days == null) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.av_timer),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: tinggi / 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: TextWidget(
                          text:
                              "Hari ini  ${time.hours}:${time.min}:${time.sec}",
                          size: 16,
                          overflow: TextOverflow.ellipsis,
                          color: primer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.av_timer),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: tinggi / 30,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: TextWidget(
                        text:
                            "${time.days} Hari ${time.hours}:${time.min}:${time.sec}",
                        size: 16,
                        overflow: TextOverflow.ellipsis,
                        color: primer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          LineWiget(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.meeting_room),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: tinggi / 30,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: TextWidget(
                  text: "${widget.kelas}",
                  size: 16,
                  color: primer,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: tinggi / 151,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
              width: 2,
              color: primer,
            ))),
            child: Column(
              children: [
                SizedBox(
                  height: tinggi / 60,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.menu_book),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: tinggi / 30,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: TextWidget(
                        text: "Catatan :",
                        size: 16,
                        color: primer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: tinggi / 70,
                ),
                // Divider(height: 1,color: Colors.grey,thickness: 1,),
                QuillEditor(
                  controller: _controller,
                  scrollController: ScrollController(),
                  scrollable: true,
                  autoFocus: false,
                  readOnly: true,
                  expands: false,
                  minHeight: tinggi / 1.55,
                  maxHeight: tinggi / 1.55,
                  padding: EdgeInsets.only(left: 4),
                  focusNode: FocusNode(canRequestFocus: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineWiget extends StatelessWidget {
  const LineWiget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: primer,
    );
  }
}
