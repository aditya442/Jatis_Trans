import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;
import 'package:jatis_trans/Halaman_Home.dart';
import 'package:jatis_trans/Halaman_Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';


class Registrasi extends StatefulWidget{
  @override
  RegistrasiState createState()=> RegistrasiState();
}
class RegistrasiState extends State<Registrasi>{
  final formKey = GlobalKey<FormState>();


  bool _idHidePassword = true;
  void _Passwordvisibility() {
    setState((){
      _idHidePassword = !_idHidePassword;
    });
  }


  TextEditingController controlleruser_name  = new TextEditingController();
  TextEditingController controllerphone_no = new TextEditingController();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();



  void addData(){
    var url="http://adityo.xyz/jatis_trans/registrasi.php";

    http.post(url, body: {
      "user_name": controlleruser_name.text,
      "phone_no": controllerphone_no.text,
      "email" : controlleremail.text,
      "password" : controllerpassword.text,


    });

    print(http.Response);
  }


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Registrasi'),
        ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: SafeArea(
              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 70,),
                    Container(
                      margin: EdgeInsets.only(left: 40,right: 40),
                      child: TextFormField(
                        controller: controlleruser_name,
                        onChanged: (String value){},
                        //    cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Nama",
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value.length<4) {
                            return 'Nama Minimal 4 Karakter';
                          }
                          return null;

                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.only(left: 40,right: 40),
                      child: TextFormField(
                        controller: controllerphone_no,
                        onChanged: (String value){},
                        //    cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "No hp",
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.length <= 11) {
                            return 'No Hp Tidak Boleh Kosong';
                          }
                          return null;

                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.only(left: 40,right: 40),
                      child: TextFormField(
                        controller: controlleremail,
                        onChanged: (String value){},
                        //    cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.only(left: 40,right: 40),
                      child: TextFormField(
                        controller: controllerpassword,
                        obscureText:_idHidePassword,
                        onChanged: (String value){},
                        //    cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          suffixIcon:GestureDetector(
                            onTap:(){
                              _Passwordvisibility();
                            } ,
                            child: Icon(
                                _idHidePassword ?Icons.visibility_off:Icons.visibility,
                                color: _idHidePassword ?Colors.grey :Colors.lightBlueAccent
                            ),
                          ),
                          labelText: "Password",
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value.length<4) {
                            return 'Password Minimal 4 Karakter';
                          }
                          return null;

                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    RaisedButton(
                        child: Text(
                          "Registrasi",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),),
                        textColor: Colors.white,
                        color: Color(0xffff3a5a),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        onPressed: (){
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Halaman_Navigation();
                                    }
                                )
                            );
                          }

                          addData();
                        }
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}