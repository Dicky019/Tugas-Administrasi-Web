import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';
import 'package:management_tugas/widget/text_widget.dart';

import '../assets.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('user');
  final List<String> itemsPelajaran = <String>[
    'HARDWARE',
    'PROGRAM',
    'MULTIMEDIA',
    'NETWORK',
  ];
  final List<String> itemsKelas = <String>[
    'Kelas F',
    'Kelas G',
    'Kelas H',
    'Kelas I',
  ];
  var pelajaran;
  var kelas;
  bool hintMatkul = true,hintKelas = true,_loading = false;
  late int age = 0;
  var i = "";
  late String deatline = '';
  late DateTime pickedDate;
  int endTime = DateTime
      .now()
      .millisecondsSinceEpoch + 1000 * 30;
  late QuillController _controller;
  late TextEditingController _controllerTanggal = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
    // if (_controllerTanggal.text == "") {
    //   _controllerTanggal.text = "Deatline";
    // }
    pickedDate = DateTime.now();
  }

  Future<void> _loadFromAssets() async {
    try {
      final doc = Document()
        ..insert(0, 'Catatan');
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      final doc = Document()
        ..insert(0, error.toString());
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  void dispose() {

    _controllerTanggal.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
        iconTheme: IconThemeData(color:primer),
        // actions: [IconButton(onPressed: (){}, icon: Icon(Icons.save_rounded)),],
        title: TextWidget(
          size: 22,
          color: primer,
          fontWeight: FontWeight.bold,
          text: "Add Your Task",
        ),
      ),
      body: _loading == false ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: pelajaran,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 26,
                                ),
                                items: itemsPelajaran
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            text: item,
                                            color: primer,
                                            size: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      value: item,
                                    ))
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() {
                                      this.pelajaran = value!;
                                      hintMatkul = false;
                                    }),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: hintMatkul,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Konsentrasi",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      LineWiget()
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: kelas,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    size: 26,
                                  ),
                                  items: itemsKelas
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              text: item,
                                              color: primer,
                                              size: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                        value: item,
                                      ))
                                      .toList(),
                                  onChanged: (value) =>
                                      setState(() {
                                        this.kelas = value!;
                                        hintKelas = false;
                                      }),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: hintKelas,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Kelas",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        LineWiget(),
                      ],
                    ))
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: DateTimeField(
                style: TextStyle(color: primer),
                controller: _controllerTanggal,
                decoration: InputDecoration(

                  hintText: "DeadLine",
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.event,
                      size: 26,
                      color: Colors.black,
                    ),
                  ),
                ),
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(pickedDate.year),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2025));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    // setState(() {
                    //   endTime = DateTimeField.combine(date, time)
                    //       .millisecondsSinceEpoch;
                    // });
                    final formatForinput =
                    DateFormat("yyyy-MM-dd HH:mm:ss");
                    i = formatForinput
                        .format(DateTimeField.combine(date, time));

                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
            LineWiget(),
            QuillToolbar.basic(

                multiRowsDisplay: false,
                showHorizontalRule: true,
                showBackgroundColorButton: false,
                showClearFormat: false,
                showCodeBlock: false,
                showHeaderStyle: false,
                showStrikeThrough: false,
                controller: _controller,
            ),
            Container(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            )
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(onPressed: (){
        // print(_controller. document.toPlainText());
        // print(i);
        // print(pelajaran);
        add();
      },child: Icon(Icons.save_rounded),),
    );
  }
  Future add() async{
    String catatan = _controller.document.toPlainText().toString();
    setState(() {
      _loading = !_loading;
    });
    DocumentReference collection = await collectionReference.add({
      'pelajaran': pelajaran.toString() == "" ? "Belum Diisi" : pelajaran.toString(),
      'kelas': kelas.toString() == "" ? "Belum Diisi" : kelas.toString(),
      'deadline': i == "" ? "Belum Diisi" : i,
      'catatan' : catatan == "" ? "Belum Diisi" : catatan
    }).whenComplete(() {
      setState(() {
        _loading = !_loading;
      });
    });

    return collection;
  }
}



class LineWiget extends StatelessWidget {
  const LineWiget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(height: 2,thickness: 2,color: primer,);
  }
}

