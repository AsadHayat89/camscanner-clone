import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:image_picker_test/Constants/Constant.dart';
import 'package:image_picker_test/Constants/global.dart';
import 'package:image_picker_test/Notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Seetings.dart';
import '../main.dart';
import '../pdfApi.dart';
import '../tryFilter.dart';
import 'method.dart';

class recent extends StatefulWidget {
  final String uid;
  const recent({Key key,
    this.uid
  }) : super(key: key);

  @override
  _recentState createState() => _recentState();
}

class _recentState extends State<recent> {
  String logiK=null;
  List<File> newfiles=[];
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    adddirectry();
    convertFiles();
    return Scaffold(
      backgroundColor:backgroundColor,
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: color,
        leading:IconButton(
          onPressed: (){

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
      body:Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => tryFilter()));
                      },

                          child: Text("Capture",

                          style: TextStyle(
                           fontSize: 20,
                            color: TextColor
                          )),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red),
                        ),
                        height: size.height/5,
                        minWidth: size.width/2.4,

                      color: color,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlatButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home()));
                      },
                        child: Text("Catagories",
                            style: TextStyle(
                              fontSize: 20,
                                color: TextColor
                            )),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red),
                        ),
                        height: size.height/5,
                        minWidth: size.width/2.4,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Noti()));
                      },
                        child: Text("Notifications",style: TextStyle(
                          fontSize: 20,
                            color: TextColor
                        )),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red),
                        ),
                        height: size.height/5,
                        minWidth: size.width/2.4,
                        color: color,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlatButton(onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context) => setting()),(Route<dynamic> route) => false);

                      },
                        child: Text("Settings",style: TextStyle(
                          fontSize: 20,
                            color: TextColor
                        )),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red),
                        ),
                        height: size.height/5,
                        minWidth: size.width/2.4,
                        color: color,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Recently",
            style: TextStyle(
              fontSize: 20,
                color: TextColor,
              fontWeight: FontWeight.bold
            )),
          ),
          Center(
            child:ListView.builder(
              shrinkWrap: true,//if file/folder list is grabbed, then show here
              itemCount: newfiles?.length ?? 0,
              //physics: NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                return Card(
                  color: boxColor,
                    child:ListTile(
                      title: Text( newfiles[index].path.split('/').last,
                      style: TextStyle(
                        color: TextColor
                      ),),
                      leading: Icon(Icons.picture_as_pdf,
                      color: iconColor,),

                      trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ViewPDF(pathPDF: newfiles[index].path.toString());
                          //open viewPDF page on click
                        }));
                      },
                    )
                );
              },
            ),
          ),
        ],
      ),

    );
  }
  convertFiles(){
    int i=0;
    for(var f in recently){
   //   print("File"+f.path);
      if(i<2){
        newfiles.add(f);
        i++;
      }
      else{
        break;
      }
    }

  }
  adddirectry() async {
    final pdfFile =await PdfApi.CreateDirectrybyList(catagory1);

  }
}
class ViewPDF extends StatelessWidget {
  String pathPDF = "";
  ViewPDF({this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold( //view PDF
      appBar: AppBar(
        title: Text("Document",style: TextStyle(color: TextColor),),
        backgroundColor: color,
      ),
      path: pathPDF,

    );
  }
}