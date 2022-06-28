import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:image_picker_test/pdfApi.dart';
import 'package:image_picker_test/Constants/global.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker_test/tryFilter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

import 'Constants/Constant.dart';
import 'Firebase/Recent.dart';

class Noti extends StatefulWidget {
  const Noti({Key key}) : super(key: key);

  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  //var files;
  var _tapPosition;
  @override
  void initState(){
    //getFiles();

    super.initState();
  }
  void _showCustomMenu(int index1) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
      context: context,

      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size   // Bigger rect, the entire screen
      ),
      //context: context,

      items: <PopupMenuEntry<int>>[
        PopupMenuItem(

          //value: this.files,
          child: Column(

            children: <Widget>[


              GestureDetector(
                  onTap: () {

                    //taskList.add(files[index1]);
                    Navigator.pop(context);
                    (context as Element).reassemble();
                  },
                  child:Row(
                    children: [
                      Icon(Icons.notifications),
                      Text(" "),
                      Text("Set Remender"),
                    ],
                  )

              ),
              Divider(

              ),
              GestureDetector(
                  onTap: () {
                    print("check");
                    Navigator.pop(context);
                    (context as Element).reassemble();
                  },
                  child:Text("Delete")
              ),


            ],

          ),
        ),

      ],


    );

  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: color,
        title: Text("Pdf List"),
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
      ),
      body: Container(
        child: ListView.builder(  //if file/folder list is grabbed, then show here
          itemCount: taskList?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: (){
                _showCustomMenu(index);
              },

              onTapDown: _storePosition,

              child: Card(
                  color: boxColor,
                  child:ListTile(
                    title: Text(taskList[index].path.split('/').last,style: TextStyle(color: TextColor),),
                    leading: Icon(Icons.picture_as_pdf,color: iconColor,),

                    trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ViewPDF(pathPDF:taskList[index].path.toString(),f:taskList[index]);
                        //open viewPDF page on click
                      }));
                    },
                  )
              ),
            );
          },
        ),
      ),
    );




  }

}





class ViewPDF extends StatelessWidget {
  String pathPDF = "";
  File f;
  ViewPDF({this.pathPDF,this.f});
  @override
  Widget build(BuildContext context) {
    recently.insert(0, f);
    return PDFViewerScaffold( //view PDF
      appBar: AppBar(
        title: Text("Document",
          style: TextStyle(
              color: TextColor
          ),),
        backgroundColor: color,
      ),
      path: pathPDF,

    );
}}
