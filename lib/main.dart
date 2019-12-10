import 'package:flutter/material.dart';
import 'package:jatis_trans/splash_screen.dart';
import 'package:jatis_trans/Login.dart';
import 'package:jatis_trans/registrasi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash_Screen(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => new Login()
     //   '/Registasi':(BuildContext context )=> new Registrasi()
      },

    );
  }
}
