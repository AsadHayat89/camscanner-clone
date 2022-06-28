import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_test/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Constant.dart';
import 'Constants/global.dart';
import 'Firebase/Recent.dart';
import 'Firebase/method.dart';
import 'Signup.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginHome(title: 'Login',);
  }
}

class LoginHome extends StatefulWidget {
  LoginHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<LoginHome> {
  var Email = TextEditingController();
  var UserNAme = TextEditingController();
  String Name,UserName;
  User currentUser;
  @override
  void initState(){
//  getFiles();
//    adddirectry();//call getFiles() function on initial state.
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(widget.title,style: TextStyle(color: Color(0xff001035)),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black45),
            onPressed: () =>  Navigator.pop(context),
          ),

        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        width: 50,
                        height: 100,
                     //   color: Colors.lightGreen,
                       //   child: Animationdata(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: Email,
                        decoration: InputDecoration(
                          hintText: 'Email',

                          //labelText: 'Email',
                          prefixIcon: Icon(
                              Icons.person,
                            color: color,
                          ),

                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: UserNAme,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          //labelText: 'Password',

                          prefixIcon: Icon(
                              Icons.lock_outline,
                            color: color,
                          ),

                        ),
                        cursorColor: color,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        minWidth: 400.0,
                        height: 60,

                        child: Container(
                          child: RaisedButton(
                            onPressed: (){
                                var d=UserNAme.text;
                                UserName=d;
                                Name=Email.text;
                                if(Name.isNotEmpty && UserName.isNotEmpty){
                                  sigin(Name.trim(), UserName.trim(), context);
                                  /**
                                      var User=logIn(Name.trim(),UserName);
                                      User.toString();
                                      if(User==null){
                                        print("Login faild");

                                      }
                                      else{

                                        print("Login"+ User.toString());
                                        check();
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return Home();
                                          //open viewPDF page on click
                                        }));
                                      }
                                   **/
                                }

                                //else{
                                //  print(Name);

                            },

                            shape: RoundedRectangleBorder(
                            ),
                            padding: const EdgeInsets.all(8.0),
                            textColor: Colors.white,
                            disabledTextColor: Colors.white,
                            disabledColor: Colors.blueAccent,
                            color: color,
                            child: new Text("Log In"),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        minWidth: 400.0,
                        height: 60,
                        child: Container(
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return RegisterScreen();
                                //open viewPDF page on click
                              }));
                            },
                            shape: RoundedRectangleBorder(
                            ),
                            padding: const EdgeInsets.all(8.0),
                            textColor: Colors.white,
                            disabledTextColor: Colors.white,
                            disabledColor: Colors.blueAccent,
                            color: color,
                            child: new Text("Sign Up"),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
Future<User> sigin(String e,String p,context) async{
  print("email  :"+e);
  print("password:  "+p);
  var user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: e, password:p);
  print("User id: "+user.user.uid);
  final SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString("Id", user.user.uid);
  Navigator.push(context, MaterialPageRoute(builder: (context) => recent(uid: user.user.uid)));
}