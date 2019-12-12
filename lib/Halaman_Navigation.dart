import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jatis_trans/Halaman_History.dart';
import 'package:jatis_trans/Halaman_Profile.dart';
import 'package:jatis_trans/Halaman_Home.dart';



class Halaman_Navigation extends StatefulWidget {
  List list;
  int index;
  Halaman_Navigation({this.list,this.index});
  @override
  NavigationState createState() => NavigationState();
}

class  NavigationState extends State<Halaman_Navigation> {


  final pages = [
    Halaman_Home(),
    Halaman_History(),
    Halaman_Profile(),
  ];

  int selectedIndex = 0;

  void ontap(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              title: Text('History')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              title: Text('Profile')
          ),
        ],

        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.orangeAccent,
        onTap:((int index){
          setState(() {
            selectedIndex = index ;
          });
        }),
      ),
      body: pages.elementAt(selectedIndex),
    );
  }
}
