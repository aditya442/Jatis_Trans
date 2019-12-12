import 'package:flutter/material.dart';

class Pilih_Armada extends StatefulWidget{
  @override
  ArmadaState createState()=> ArmadaState();
}
class ArmadaState extends State<Pilih_Armada> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Armada Bus'),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
