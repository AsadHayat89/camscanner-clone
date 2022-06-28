
import 'package:path/path.dart' as path;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:async';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'Constants/global.dart';

//import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfApi {
  static CreateDirectry(String name) async {
    //final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final dir = await getExternalStorageDirectory();
    final Directory _appDocDirFolder = Directory('${dir.path}/$name/');
    if(await _appDocDirFolder.exists()){ //if folder already exists return path
      return _appDocDirFolder.path;
    }

    else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
  static CreateDirectrybyList(List<cat> data) async {
    for (cat rm in data) {
      final dir = await getExternalStorageDirectory();
      String name=rm.name;
      //final Directory _appDocDir = await getApplicationDocumentsDirectory();
      final Directory _appDocDirFolder = Directory('${dir.path}/$name/');
      //print(_appDocDir.path);
      print(dir.path);
      if (await _appDocDirFolder.exists()) {
        print("Already exsist");//if folder already exists return path
      //  return _appDocDirFolder.path;
      }
      else{
        final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
        print("created");
        //return _appDocDirNewFolder.path;
      }
    }
  }

 static final pdf = pw.Document();

   static createPDF(List<File> _image,String name,BuildContext context,String directry) async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
    savePDF(name,context,directry);
  }
 static savePDF(String name,BuildContext context,String directry) async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir.path}/${directry}/${name}.pdf');
      await file.writeAsBytes(await pdf.save());
      print('success'+ 'saved to documents');
    } catch (e) {
      print('error'+ e.toString());
    }
    show_Title_n_message_Flushbar(context);
  }

 static void show_Title_n_message_Flushbar(BuildContext context) {
   Flushbar(
     title: 'Success',
     message: 'Pdf created successfully',
     icon: Icon(
       Icons.done_outline,
       size: 28,
       color: Colors.green.shade300,
     ),
     leftBarIndicatorColor: Colors.blue.shade300,
     duration: Duration(seconds: 3),
   )..show(context);
 }


  static savePDFFile(File f,String directry)async{
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir.path}/${directry}/${f}');
      await file.writeAsBytes(await pdf.save());
    print('success'+ 'saved to documents');
    } catch (e) {
    print('error'+ e.toString());
    }
  }

  static move(File sourceFile,String newPath) async{
    try{
      var basNameWithExtension = path.basename(sourceFile.path);
      print(basNameWithExtension);
      //var file =  await moveFile(sourceFile,newPath+"/"+basNameWithExtension);
      final dir = await getExternalStorageDirectory();
      final file = File('${dir.path}/${newPath}/${basNameWithExtension}');
      await file.writeAsBytes(await pdf.save());
      deleteFile(sourceFile);
      print(":create");
    }on FileSystemException catch (e) {

      print(e.message);
      return null;
    }

   }
   static Future<int> deleteFile(File source) async {
     try {
       final file = await source;

       await file.delete();
     } catch (e) {
       print("delete, "+e.toString());
       return 0;
     }
   }
   static deleteTrash()async{
     final dir = await getExternalStorageDirectory();
     final file = File('${dir.path}/Trash');
     final dir2 = Directory(file.path);
     dir2.deleteSync(recursive: true);
     CreateDirectry('Trash');

     print("deleted scussfully");
   }


}
