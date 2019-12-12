import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jatis_trans/Halaman_Home.dart';
import 'package:jatis_trans/Halaman_Navigation.dart';


class Tujuan extends StatefulWidget{
  @override
  TujuanState createState()=> TujuanState();
}
class TujuanState extends State<Tujuan>{
  Future _futurePopuler, _futureSemuaPesawat;

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
      body: new 
                    FutureBuilder(
                      future: _futurePopuler,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                for (int i = 0; i < snapshot.data.airport.length; i++)
                                  new ListTile(title: new Text(snapshot.data.airport[i].city_name + ", " + snapshot.data.airport[i].pool_name,style: TextStyle(fontWeight: FontWeight.w600),),
                                    leading: Icon(Icons.location_city,color: Colors.blue[800],),
                                    subtitle: Text(
                                        'Semua Bandara'
                                    ),
                                    trailing: Container(
                                      height: 30,
                                      // color: Colors.orange,
                                      child: RaisedButton(
                                          child: Text(snapshot.data.airport[i].arrival_city,style: TextStyle(fontSize: 14,color: Colors.blue[900]),),
                                          //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          color: Colors.white12,
                                          onPressed: (){
                                            Navigator.pop(context, [snapshot.data.airport[i].city_name,snapshot.data.airport[i].arrival_city]);
                                          }),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context, [snapshot.data.airport[i].city_name,snapshot.data.airport[i].arrival_city]);
                                    },
                                  ),
                              ],
                            ) ,
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    )

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
            onTap: ()=>Navigator.pop(context,list[i]['city_name']),
              child: Card(
                child: new ListTile(

                  title: new Text('${list[i]['city_name']} - ${list[i]['pool_name']} '),
                 leading: Icon(Icons.location_city,color: Colors.blue[900],),
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

