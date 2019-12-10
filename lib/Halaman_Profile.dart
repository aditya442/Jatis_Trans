import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jatis_trans/Login.dart';

class Halaman_Profile extends StatefulWidget{
  @override
  ProfileState createState()=> ProfileState();
}
class ProfileState extends State<Halaman_Profile>{
  void confirm (){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin ingin Keluar"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("Batal",style: new TextStyle(color: Colors.white),),
          color: Colors.orangeAccent,
          onPressed:  ()=> Navigator.pop(context)
        ),
        SizedBox(height: 30,),
        new RaisedButton(
          child: new Text("Iya",style: new TextStyle(color: Colors.white)),
          color: Colors.orangeAccent,
          onPressed: ()async {
          // hapus shared prefs login
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('login');
          // redirect page/route ke login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  String user_id;
  String user_name;
  String email;

  @override
  void initState() {
    super.initState();
    getuser_name();
    getemail();
    getid();
  }

  getuser_name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_name =  prefs.getString('user_name');

    });
  }
  getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      email = prefs.getString('email');

    });
  }

  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      user_id = prefs.getString('id');

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text('Jatis Trans',style: TextStyle(fontWeight: FontWeight.w900),),)
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
               Container(
                 margin: EdgeInsets.only(left: 5,right: 5),
                 child: Card(

                   child: ListTile(
                     onTap: (){},
                     leading:  CircleAvatar(backgroundColor: Colors.deepPurpleAccent,child: new Text(''),),

                     /* Container(
                       alignment: Alignment.topLeft,
                       height: 50.0,
                       width: 50.0,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(25.0),
                           border: Border.all(
                               color: Colors.orangeAccent,
                               style: BorderStyle.solid,
                               width: 2.0),
                           image: DecorationImage(
                               image: AssetImage('assets/images/person.jpg'))),
                     ),
                     */
                     title: Column(
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left: 50),
                           child: Text(user_name),
                         ),
                        // Text('0823456789'),
                         Text(email)
                       ],
                     ),
                     trailing: Icon(Icons.arrow_forward_ios),
                   ),
                 ),
               ),
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(right: 5,left: 5),
                  child: Card(
                     child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text('Penumpang Pendamping'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Bantuan'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Tengtang Kami'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Pengaturan'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text('Log Out'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap:()=>confirm(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}