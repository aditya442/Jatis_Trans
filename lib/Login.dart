import 'package:flutter/material.dart';
import 'package:jatis_trans/Halaman_Home.dart';
import 'package:jatis_trans/registrasi.dart';
import 'package:jatis_trans/Halaman_Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Response {
  final String status;
  final String message;
  final String user_id;
  final String user_name;
  final String email;
  final String password;
  Response({this.status, this.message,this.user_id,this.email,this.user_name,this.password});


  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: json['status'],
      message: json['message'],
      user_id: json['user_id'],
      user_name: json['user_name'],
      email:  json['email'],
      password: json['password'],

    );
  }
}
class Login extends StatefulWidget{
  @override
  LoginState createState()=>LoginState();
}
class LoginState extends State<Login>{
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();

  void validateInput(){
    FormState form = this.formkey.currentState;
    ScaffoldState scaffold = this.Scaffoldkey.currentState;

    SnackBar message = SnackBar(
      content: Text('Proses validasi Sukses'),
    );
    if (form.validate()){
      scaffold.showSnackBar(message);
    }
  }

  bool _idHidePassword = true;
  void _Passwordvisibility() {
    setState((){
      _idHidePassword = !_idHidePassword;
    });
  }


  // variabel member class
  final email = TextEditingController();
  final password = TextEditingController();

  // member response
  String _response = '';
  bool _apiCall = false;
  String id_user = '';
  String _user_name = '';
  String _email = '';
  // login shared prefs
  bool alreadyLogin = false;

  // fungsi untuk kirim http post
  Future<Response> post(String url,var body)async{
    return await http
        .post(Uri.encodeFull(url), body: body, headers: {"Accept":"application/json"})
        .then((http.Response response) {

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Response.fromJson(json.decode(response.body));
    });
  }


  // fungsi panggil API
  void _callPostAPI() {
    post(
        'http://adityo.xyz/jatis_trans/login.php',
        {
          'email': email.text,
          'password': password.text,

        }).then((response) async {
      // jika respon normal
      setState(() {
        _apiCall = false;
        _response = response.message;
        id_user =response.user_id;
        _user_name = response.user_name;
        _email = response.email;


        print(id_user);

      });
      print(response);

      if (response.status == "success") {

        // simpan shared prefs sudah login
        // final prefs = await SharedPreferences.getInstance();

        setState(()async {
          alreadyLogin = true;
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('login', alreadyLogin);
          prefs.setString('user_name', _user_name);
          prefs.setString('user_id', id_user);
          prefs.setString('email', _email);


          print(_user_name);
          print(id_user);
          print(_email);

          print(response);
        });

        // menuju route Halaman utama
        Navigator.push(context, MaterialPageRoute(builder: (context) => Halaman_Navigation()));
      }

    },
        // jika respon error
        onError: (error) {
          _apiCall = false;
          _response = error.toString();
        }
    );
  }

  Widget progressWidget() {
    if (_apiCall)
      // jika masih proses kirim API
      return AlertDialog(
        content: new Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Please wait")
          ],
        ),
      );
    else
      // jika sudah selesai kirim API
      return Center(
        child: Text(
          _response,
          style: new TextStyle(fontSize: 15.0),
        ),
      );
  }

  Future<bool> getLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('login') ?? false;
    print('login status $loginStatus');

    return loginStatus;

  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getLoginStatus(),
      builder: (context, snapshot) {
        return (snapshot.data) ?
        // jika sudah login tampilkan list product
        new Halaman_Navigation() :
        // jika belum login tampilkan form login
        loginForm();
      },
    );
  }

  Widget loginForm() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: SafeArea(
            child:  Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                Container(
                  child:  Image.asset('assets/images/logo2.jpg',height:200,),
                ),
                SizedBox(height: 30,),

               Container(
                 margin: EdgeInsets.only(left: 40,right: 40),
                 child: TextFormField(
                   controller: email,
                        onChanged: (String value){},
                    //    cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                            validator: (value) {
                          if (value.isEmpty) {
                       return 'Email Tidak Boleh Kosong';
                     }
                     return null;

                   },
                      ),
               ),

                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 40,right: 40),
                  child: TextFormField(
                    controller: password,
                    obscureText:_idHidePassword,
                    onChanged: (String value){},
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
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
                      if (value.isEmpty) {
                        return 'Password Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30,),
                progressWidget(),
              RaisedButton(
                  child: Text(
                    "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),),
                  textColor: Colors.white,
                  color: Color(0xffff3a5a),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  onPressed: (){
                    if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                  }
                  setState(() {
                    _apiCall = true;
                  });
                  _callPostAPI();

                  }
              ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Belum Punya akun?',style: TextStyle(color: Colors.blue,fontSize: 15),),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (BuildContext context) {
                                 return Registrasi();
                               }
                           )
                       );

                     },
                       child: Text('  Registrasi',style: TextStyle(color: Colors.blue,fontSize: 15),),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}