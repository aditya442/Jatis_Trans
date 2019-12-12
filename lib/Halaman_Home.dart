import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:jatis_trans/keberangkatan_tujuan.dart';
import 'package:jatis_trans/tujuan.dart';
import 'package:jatis_trans/pilih_armada.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';




String _kabinKelas, _asal, _tujuan, _kodeAsal, _kodeTujuan;
String _asal1, _tujuan1, _kodeAsal1, _kodeTujuan1;
String _hariIni,_hariPergi, _hariPulang, _jumlahPenumpangAll;
int _dari_ke;
class Halaman_Home extends StatefulWidget{
  List list;
  int index;
  Halaman_Home({this.list,this.index});
  @override
  HomeState createState()=> HomeState();
}
class HomeState extends State<Halaman_Home>{
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asal = "Masukkan Kota Tujuan";
    _kodeAsal = "JKT";
    _tujuan = "Denpasar";
    _kodeTujuan = "DPS";
    _dari_ke = 0;
    _hariPergi = _hariIni;
    _hariPulang = _hariIni;
    //print(tanggalPergi_1);
    //print(tanggalPulang_1);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: SafeArea(
          child:  Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.orange[400],
                title: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Jatis Trans',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w900),)

                    ],
                  ),


                ),
              ),
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                        height:300,
                        width: double.infinity,
                        color: Colors.orange[400],

                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        // padding: EdgeInsets.only(top: 0),
                        child:  CarouselSlider(

                          //  aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          // autoPlayCurve: Curve.fastOutSlowIn,
                          pauseAutoPlayOnTouch: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          // onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,

                          //  height: 150.0,

                          items: [
                            'assets/images/promo01.png',
                            'assets/images/promo02.png',
                            'assets/images/promo03.png'


                          ].map((i) {

                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  //  height: 70,
                                    width: double.infinity,
                                    //width: MediaQuery.of(context).size.width,

                                    margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 20) ,
                                    // padding: EdgeInsets.only(right: 20,left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),

                                      color: Colors.transparent,
                                    ),
                                    child: Image.asset((i))


                                );

                              },

                            );
                          }).toList(),

                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 10,left: 10),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 5),
                                child: Row(

                                  children: <Widget>[
                                    Text('Keberangkatan',style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                              //Text("city_name: ${widget.list[widget.index]['city_name']? 'tes isi ' : 'tes kosong'}")

                              new ListTile(title:new Text(_asal),
                                  leading: Icon(Icons.location_city,color: Colors.blue[800],),
                                  onTap: (){
                                    final result = Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return Tujuan();
                                            }
                                        )
                                    );
                                     result.then((result) {
                                        if(result==null) {
                                          return;
                                        }
                                        var testList = result.toList();
                                        setState(() {
                                          _asal = result[0].toString();
                                          _kodeAsal = result[1].toString();
                                          _asal1 = result[0].toString();
                                          _kodeAsal1 = result[1].toString();
                                        });
                                      });
                                  }
                              ),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(left: 20,top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Tujuan',style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                              ),
                              //(widget.list[widget.index]['city_name'] == null) ? Text('Masukan kota keberangkatan') : Text('${widget.list[widget.index]['city_name']} - ${widget.list[widget.index]['pool_name']}'),
                              new ListTile(title: Text(''),
                                  leading: Icon(Icons.location_city,color: Colors.blue[800],),
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return Tujuan();
                                            }
                                        )
                                    );
                                  }
                              ),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(right: 10,left: 18),
                                child: DateTimeField(
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(Icons.email,color: Colors.lightBlueAccent,),
                                    hintText: 'Masukkan Tanggal',
                                    border: InputBorder.none,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(Icons.calendar_today,color: Colors.blue[800],),
                                    ),
                                    hintStyle: TextStyle( color: Colors.black),

                                  ),
                                  format: format,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              Divider(),

                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              RaisedButton(
                  color: Colors.yellow,
                  child: Text('CARI',style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w700,
                  ),),
                  padding: EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Pilih_Armada();
                            }
                        )
                    );
                  }
              ),
            ],
          ),
        ),

      ),
    );
  }
}