import 'dart:js';

import 'package:flutter/material.dart';
import 'package:management_tugas/Pages/input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../assets.dart';
import '../widget/categori_widget.dart';
import '../widget/list_widget.dart';
import '../widget/text_widget.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int task = 0;
  String nameCategori = "Personal";
  bool border = false, sucses = false;
  double valueCategori = 0;

  void tekanTombol() {
    setState(() {
      border = !border;
    });
  }

  void onsucses() {
    setState(() {
      sucses = !sucses;
      sucses == true ? valueCategori = 1 : valueCategori = 0;
    });
  }

  var alertStyle = AlertStyle(
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    descTextAlign: TextAlign.center,
    descStyle: TextStyle(fontSize: 14),
  );

  alert() {
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
          onPressed: () => Navigator.pop(this.context),
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
                text: "What's Up, Dicky!",
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
                  text: "TASKS LIST"),
              SizedBox(
                height: 10,
              ),
              ListTask(
                sucses: sucses,
                onTapSucses: onsucses,
                onTapCancel: alert,
                nameCategori: nameCategori,
                nameTask: "tugas 1",
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(100, 14, 239, 1),
        onPressed: (){
           Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => InputPage()));
        },
        tooltip: 'Add Tugas',
        child: Icon(Icons.add),
      ),
    );
  }
}