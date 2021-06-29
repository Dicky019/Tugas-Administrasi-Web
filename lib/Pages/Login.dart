import 'package:flutter/material.dart';
import 'package:management_tugas/Pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  Future login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', name.text).whenComplete(() => Navigator.push(
        context, PageTransition(type: PageTransitionType.fade, child: Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: "Enter Your Name...",
                  labelText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            OutlinedButton.icon(
                onPressed: login, icon: Icon(Icons.login), label: Text("Login"))
          ],
        ),
      ),
    );
  }
}
