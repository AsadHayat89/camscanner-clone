import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker_test/pdfApi.dart';

import 'Constants/Constant.dart';
import 'Constants/global.dart';
import 'Firebase/Recent.dart';
import 'Firebase/method.dart';


class setting extends StatefulWidget {
  const setting({Key key}) : super(key: key);

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  String Name=null;
  String email=null;
  var textValue = 'Switch is OFF';
Future<void> set() async {
  email=await FirebaseAuth.instance.currentUser.email.toString();
  Name=await FirebaseAuth.instance.currentUser.uid.toString();

}

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        color=Colors.black26;
        backgroundColor=Colors.white12;
        iconColor=Colors.white;
        boxColor=Colors.black26;
        //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        TextColor=Colors.white;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:color, // navigation bar color
          statusBarColor: color, // status bar color
        ));

      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        color=Colors.lightGreen;
        boxColor=Colors.white;
        backgroundColor=Colors.white;
        iconColor=Colors.black45;
        TextColor=Colors.black45;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:Colors.white, // navigation bar color
          statusBarColor: Colors.lightGreen.shade600 // status bar color
        ));
        //textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');

    }
  }
  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {

        //  var messageController = TextEditingController();
        return AlertDialog(
          title: Text('User Information'),
          content: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email",style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),),
                        Text(email==null?"Null":email,style: TextStyle(
                            color: Colors.black,
                            fontSize: 10
                        ),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status",style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),),
                        Text("Login",style:TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),

          ],
        );
      },
    );
  }
    @override
  Widget build(BuildContext context) {
    set();
    //print("Email: "+email);
      //print("ANme: "+Name);
      var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:backgroundColor,

      appBar: AppBar(

        //elevation: 0,
        backgroundColor: color,
        leading:IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return recent();
              //open viewPDF page on click
            }));
          },
          icon:Icon(Icons.arrow_back_outlined,
            color: iconColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed:(){
                logOut(context);
              },
              icon: Icon(Icons.logout,
                color:iconColor,

              )
          ),
          IconButton(
              onPressed: () async {

              },
              icon: Icon(Icons.email,
                  color: iconColor
              ))
        ],
      ),
      body: Column(

        //mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              Padding(

                padding: EdgeInsets.all(10.0),
              child: Text(
                "Black Mode",
                style: TextStyle(
                  fontSize: 19,
                  color: TextColor
                ),

              ),
              ),


                Align
                  (
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1,
                    child: Center(

                      child: Switch(
                        onChanged:toggleSwitch,
                        value: isSwitched,
                        activeColor: color,
                        activeTrackColor: color,
                        inactiveThumbColor: color,
                        inactiveTrackColor: color,
                      ),
                    ),
                  ),
                )
              ],
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(

                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Information",
                  style: TextStyle(
                      fontSize: 19,
                      color: TextColor
                  ),

                ),
              ),
              FlatButton(onPressed: (){
                showDialogWithFields();
              },
                  height: size.width/10,
                  minWidth: size.width/10,
                  color: color,
                  child: Text(
                    "Check",
                    style: TextStyle(
                        fontSize: 19,
                        color: TextColor
                    ),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(

                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 19,
                      color: TextColor
                  ),

                ),
              ),
              FlatButton(onPressed: (){
                print(email);
                FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                print("Received a mail");
              },
                  height: size.width/10,
                  minWidth: size.width/10,
                  color: color,
                  child: Text(
                    "Click",
                    style: TextStyle(
                        fontSize: 20,
                        color: TextColor
                    ),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(

                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Reset catagories",
                  style: TextStyle(
                      fontSize: 19,
                      color: TextColor
                  ),

                ),
              ),
              FlatButton(onPressed: () async {
                final pdfFile =await PdfApi.CreateDirectrybyList(catagory1);
                show_Title_n_message_Flushbar(context,"Catagories resset");
              },
                  height: size.width/10,
                  minWidth: size.width/10,
                  color: color,
                  child: Text(
                    "Click",
                    style: TextStyle(
                        fontSize: 20,
                        color: TextColor
                    ),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(

                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Empty Trash",
                  style: TextStyle(
                      fontSize: 19,
                      color: TextColor
                  ),

                ),
              ),
              FlatButton(onPressed: () async {
                await PdfApi.deleteTrash();
              },
                  height: size.width/10,
                  minWidth: size.width/10,
                  color: color,
                  child: Text(
                    "Click",
                    style: TextStyle(
                        fontSize: 20,
                        color: TextColor
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );

  }
  void show_Title_n_message_Flushbar(BuildContext context,String Message) {
    Flushbar(
      title: 'Success',
      message: Message,
      icon: Icon(
        Icons.done_outline,
        size: 28,
        color: Colors.green.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
