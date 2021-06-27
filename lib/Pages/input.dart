import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
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
  final List<String> items = <String>[
    'HARDWARE',
    'PROGRAM',
    'MULTIMEDIA',
    'NETWORK',
  ];
  var konsentrasi;

  bool hintMatkul = true;
  late int age = 0;
  late String deatline = '';
  late DateTime pickedDate;
  late TimeOfDay _time = TimeOfDay.now();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  late QuillController _controller;
  late TextEditingController _controllerTanggal = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
    if (_controllerTanggal.text == "") {
      _controllerTanggal.text = "Deatline";
    }
    pickedDate = DateTime.now();
  }

  Future<void> _loadFromAssets() async {
    try {
      final doc = Document()..insert(0, 'Catatan');
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      final doc = Document()..insert(0, error.toString());
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          size: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          text: "Add Your Task, Dicky!",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: konsentrasi,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        size: 26,
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: item,
                              color: second,
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        value: item,
                      ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.konsentrasi = value!;
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
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            LineWiget(),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: DateTimeField(
                controller: _controllerTanggal,
                decoration: InputDecoration(
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
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
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
                    var i = formatForinput
                        .format(DateTimeField.combine(date, time));
                    print(i);
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
                controller: _controller),
            Container(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            )
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? date = (await showDatePicker(
      initialDate: pickedDate,
      firstDate: DateTime(pickedDate.year - 25),
      lastDate: DateTime(pickedDate.year + 2),
      context: this.context,
    ));
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (date != null) {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      var tes = months.asMap();
      var bulan = tes[date.month - 1];
      setState(() {
        _time = newTime!;
        print(date);
        endTime = date.millisecondsSinceEpoch + 1000 * 30;
      });
    }
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

