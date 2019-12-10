import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jatis_trans/Halaman_Home.dart';


class Tujuan extends StatefulWidget{
  @override
  TujuanState createState()=> TujuanState();
}
class TujuanState extends State<Tujuan>{

  Future<List> getData() async {
    final response = await http.get("http://adityo.xyz/jatis_trans/get_pool.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(
          child:  Card(
            child: TextFormField(
              onChanged: (String value){},
              //    cursorColor: Colors.deepOrange,
              decoration: InputDecoration(
                  border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
               hintText: "Search"
               // contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
               // border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
            list: snapshot.data,
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),

    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.only(right: 5,left: 5),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context)=> new Halaman_Home(list:list , index: i,),
                ),
            ),
              child: Card(
                child: new ListTile(

                  title: new Text('${list[i]['city_name']} - ${list[i]['pool_name']} '),
                 // leading: new Icon(Icons.account_circle,color: Colors.deepPurple,),
                 // subtitle: new Text("Alamat: ${list[i]['alamat']}"),
                ),
              ),
            ),

        );
      },
    );
  }
}
