import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:management_tugas/Pages/detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:management_tugas/Pages/input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../assets.dart';
import '../widget/categori_widget.dart';
import '../widget/list_widget.dart';
import '../widget/text_widget.dart';

class Home extends StatefulWidget {
  final String name;
  const Home({Key? key, required this.name}) : super(key: key); 
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');
  int task = 0;

  String nameCategori = "Personal";
  bool border = false, sucses = false;
  double valueCategori = 0;
  int documents = 0;

  void tekanTombol() {
    setState(() {
      border = !border;
    });
  }

  var alertStyle = AlertStyle(
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    descTextAlign: TextAlign.center,
    descStyle: TextStyle(fontSize: 14),
  );

  Future delete(String id) async {
    Alert(
      style: alertStyle,
      context: this.context,
      type: AlertType.error,
      title: "Hapus",
      desc: "Apakah Tugas Ini Sudah Selesai?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            collectionReference.doc(id).delete().timeout(Duration(seconds: 3),
                onTimeout: () {
              Alert(
                context: this.context,
                title: "Timeout",
                type: AlertType.info,
                desc: "Periksa Koneksi Anda...",
              );
            }).whenComplete(() => Navigator.pop(this.context));
          },
          color: Colors.redAccent[400],
        ),
        DialogButton(
          color: Colors.purple[300],
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(this.context),
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    // print(categoriTask());
    categoriTask();
    super.initState();
  }

  Future categoriTask() async {
    var i = await collectionReference.get();
    setState(() {
      task = i.docs.length;
    });
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                size: 30,
                color: primer,
                fontWeight: FontWeight.bold,
                text: "What's Up, ${widget.name}!",
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextWidget(
                  color: primer,
                  text: "Let's finish Your Tasks!",
                  fontWeight: FontWeight.w500,
                  size: 15,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextWidget(
                  color: second,
                  size: 15.5,
                  fontWeight: FontWeight.w500,
                  text: "CATEGORIES",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Categori(
                name: nameCategori,
                task: task,
                border: border,
                value: valueCategori,
                tekanTombol: tekanTombol,
              ),
              SizedBox(
                height: 45,
              ),
              TextWidget(
                size: 16,
                color: second,
                fontWeight: FontWeight.w500,
                text: "TASKS LIST",
              ),
              task != 0
                  ? Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                      stream: collectionReference
                          .orderBy('deadline', descending: false)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: new CircularProgressIndicator(),
                                ),
                              );
                            default:
                              return ListView(
                                padding: EdgeInsets.only(top: 8),
                                children: snapshot.data!.docs
                                    .map(
                                      (e) => Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: Detail(
                                                        jurusan: e['pelajaran'],
                                                        catatan: e['catatan'],
                                                        deadline: e['deadline'],
                                                        kelas: e['kelas'],
                                                      )));
                                            },
                                            child: ListTask(
                                              nameCategori: e['pelajaran'],
                                              nameTask: e['username'],
                                              onTapCancel: () {
                                                delete(e.id);
                                              },
                                              catatan: e['tampil'],
                                              deadline: CountdownTimer(
                                                endTime: DateTime.parse(
                                                        e['deadline'])
                                                    .millisecondsSinceEpoch,
                                                widgetBuilder: (_, time) {
                                                  if (time == null) {
                                                    return Text('Game over');
                                                  }
                                                  if (time.days == null) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(Icons.av_timer),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text("Hari ini"),
                                                            Text(
                                                                '${time.hours}:${time.min}'),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Icon(Icons
                                                          .timelapse_outlined),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "${time.days} Hari"),
                                                          Text(
                                                              '${time.hours}:${time.min}'),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ))
                  : Center(
                      child: Text("No Task"),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(100, 14, 239, 1),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: InputPage()));
        },
        tooltip: 'Add Tugas',
        child: Icon(Icons.add),
      ),
    );
  }
}
