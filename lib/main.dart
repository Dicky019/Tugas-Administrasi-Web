import 'package:flutter/material.dart';
import 'assets.dart';
import 'widget/categori_widget.dart';
import 'widget/text_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int task = 0;
  String nameCategori = "Personal";
  bool border = false;
  double valueCategori = 0;
  void tekanTombol() {
    setState(() {
      border = !border;
      border == true ? valueCategori = 1 : valueCategori = 0;
    });
  }

  Future<void> showAlert() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("hello"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.2),
                            spreadRadius: -3,
                            blurRadius: 18,
                            offset: Offset(0.5, 5),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: InkWell(
                                onTap: tekanTombol,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: primer, width: 2),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: border ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 500),
                                    child: Icon(
                                      Icons.done_outline_rounded,
                                      size: 18,
                                      color: primer,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameCategori,
                                style: border == false
                                    ? TextStyle()
                                    : TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.85,
                                      ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Dicki",
                                style: border == false
                                    ? TextStyle()
                                    : TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.85,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                showAlert();
                              },
                              child: Text("data"),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(100, 14, 239, 1),
          onPressed: tekanTombol,
          tooltip: 'Add Tugas',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
