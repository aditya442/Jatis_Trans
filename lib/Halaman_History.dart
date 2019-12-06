import 'package:flutter/material.dart';


class Halaman_History extends StatefulWidget{
  @override
  HistoryState createState()=> HistoryState();
}
class HistoryState extends State<Halaman_History>{
 @override
 Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text('Jatis Trans',style: TextStyle(fontWeight: FontWeight.w900),)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/ticket.jpg'),
              ),
              Text('Belum Memesan? Pesan Ticket Terlebih Daluhu')

            ],
          ),
        ),
      ),

    );
  }
}