import 'package:flutter/material.dart';
import 'dart:async';

class Splash_Screen extends StatefulWidget{
  @override
  SplashState createState()=> SplashState();
}
class SplashState extends State<Splash_Screen>{
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                "assets/images/logo.jpg",
                width:  250,
                height:  250,
              ),
              SizedBox(height: 25,),
              Text('',style: TextStyle(color: Colors.blue[900],fontSize: 30,fontWeight: FontWeight.w700))
            ],
          ),
        ],
      ),
    );
  }
}