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
import 'main.dart';

class FileList extends StatefulWidget {
final String dirc;
  const FileList({Key key,this.dirc}) : super(key: key);
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  var files;
  var _tapPosition;
  @override
  void initState(){
    getFiles();

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

                    taskList.add(files[index1]);
                    Navigator.pop(context);
                    (context as Element).reassemble();
                  },
                  child:Row(
                    children: [
                      Icon(Icons.notifications),
                      Text(" "),
                      Text(" SetRemender"),
                    ],
                  )

              ),
              Divider(

              ),
              GestureDetector(
                  onTap: () {
                    print("check");
                    PdfApi.move(files[index1],"Trash");
                    Navigator.pop(context);
                    (context as Element).reassemble();
                  },
                  child:Row(
                    children: [
                      Icon(Icons.delete),
                      Text(" "),
                      Text(" Delete"),
                    ],
                  )

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
              return Home();
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
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: (){
                  _showCustomMenu(index);
                },

                onTapDown: _storePosition,

                child: Card(
                  color: boxColor,
                    child:ListTile(
                      title: Text(files[index].path.split('/').last,style: TextStyle(color: TextColor),),
                      leading: Icon(Icons.picture_as_pdf,color: iconColor,),

                      trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ViewPDF(pathPDF:files[index].path.toString(),f:files[index]);
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
  void getFiles() async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir;
    final dir = await getExternalStorageDirectory();
    //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory('/${dir.path}/${widget.dirc}')); //


    files = await fm.filesTree(
        excludedPaths: [dir.path],
        extensions: ["pdf"] //optional, to filter files, list only pdf files
    );
    setState(() {}); //update the UI
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
  }
}