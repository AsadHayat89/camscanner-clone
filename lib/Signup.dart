import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'Constants/Constant.dart';
import 'Firebase/method.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterHome(title: 'Register',);
  }
}

class RegisterHome extends StatefulWidget {
  RegisterHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState  extends State<RegisterHome> {
  var Email = TextEditingController();
  var UserNAme = TextEditingController();
  var Password = TextEditingController();
  var ConPass = TextEditingController();
  String txtEmail,txtUserName,txtPassword,txtConpass;
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
            icon: Icon(Icons.arrow_back, color: Colors.black),
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
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network('https://cdn.iconscout.com/icon/free/png-512/flutter-2038877-1720090.png'),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: Email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        //  labelText: 'Email',
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
                        controller:UserNAme,
                        decoration: InputDecoration(
                          hintText: 'Name',
                         // labelText: 'Name',
                          prefixIcon: Icon(
                              Icons.account_circle,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: Password,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        //  labelText: 'Password',
                          prefixIcon: Icon(
                              Icons.lock,
                            color: color,
                          ),

                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: ConPass,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                        //  labelText: 'Confirm Password',
                          prefixIcon: Icon(
                              Icons.lock,
                            color: color,
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
                              txtConpass=ConPass.text;
                              txtEmail=Email.text.trim();
                              print(txtEmail);
                              txtPassword=Password.text;
                              txtUserName=UserNAme.text;
                              if(txtUserName.isNotEmpty&&txtPassword.isNotEmpty&&txtEmail.isNotEmpty&&txtConpass.isNotEmpty){
                                var User=createAccount(txtUserName,txtEmail,txtPassword);
                                if(User==null){
                                  print("Data inserted");
                                }
                                else{
                                  print("Failed");
                                }
                              }
                              else{
                                print("Please fill the field");
                              }
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