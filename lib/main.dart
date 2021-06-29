import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:management_tugas/Pages/Login.dart';
import 'package:management_tugas/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var login = prefs.getString('username');
  runApp(MyApp(login: login,));
}

class MyApp extends StatelessWidget {
  final String? login;
  const MyApp({Key? key, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: primer, primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: login == null? Login() : Home(name: login!,),
    );
  }
}
