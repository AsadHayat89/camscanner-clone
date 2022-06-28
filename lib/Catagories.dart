import 'dart:convert';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';
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

class  catagorydata2 extends StatefulWidget {
final List<File> img2;
final String filename;

const catagorydata2({Key key,
this.filename,this.img2}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<catagorydata2> {
  Icon selectedIcon;
  String selected="null";

  @override

  Widget build(BuildContext context) {
  print("Legtn is: "+widget.img2.length.toString());
String addCat=null;
void selectIcon()async{
  IconData icon;
  //await FlutterIconPicker.showIconPicker(context,
  //iconPackMode: IconPack.cupertino
  //);
  if(icon!=null){
    setState(() {
      print("sleected");
      selected="selected";
      selectedIcon=Icon(icon,color: Colors.red);
    });

  }
}
void showDialogWithFields() {
showDialog(
context: context,
builder: (_) {
var Name = TextEditingController();
//  var messageController = TextEditingController();
return AlertDialog(
  backgroundColor: backgroundColor,
title: Text('Enter New catagory',style: TextStyle(
  color: TextColor
),),
content: ListView(
shrinkWrap: true,
children: [
TextFormField(
controller: Name,
decoration: InputDecoration(hintText: 'Name'),
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Select Icon"),
    FlatButton(onPressed: selectIcon, child: Text("select"))
  ],
)
],
),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: Text('Cancel'),
),


TextButton(
onPressed: () {
// Send them to your email maybe?
var name = Name.text;
setState(() async {
  addCat=name;

  catagory1.add(new cat(name: name,icon: selectedIcon));

  //var pdf=await PdfApi.CreateDirectry(addCat);
//catagory.add(addCat);
  Navigator.pop(context);
  (context as Element).reassemble();
});

//var message = messageController.text;
Navigator.pop(context);
},
child: Text('Send'),
),
],
);
},
);
}
return Scaffold(
  backgroundColor: backgroundColor,
appBar: new AppBar(
title: new Text('Select Your Catagory',style: TextStyle(
  color: TextColor
),),
leading:IconButton(
onPressed: (){
Navigator.of(context).push(MaterialPageRoute(
builder: (context) => tryFilter()));
},
icon:Icon(Icons.arrow_back_outlined,
color: iconColor,
),
),

backgroundColor: color,
),
body: ListView.builder(  //if file/folder list is grabbed, then show here
itemCount: catagory1.length,
itemBuilder: (context, index) {
return Card(
  color: boxColor,
child:ListTile(
title: Text(catagory1[index].name,style: TextStyle(
  color: TextColor
),),
//              leading: Icon(Icons.picture_as_pdf),

//            trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
onTap: () async{
final pdfFile =await PdfApi.createPDF(widget.img2,widget.filename,context,catagory1[index].name);
},

)
);
},
),
floatingActionButton: FloatingActionButton(
onPressed: () {
showDialogWithFields();
//catagory.add("value");

},

child: const Icon(Icons.add,
size: 20,
  ),
backgroundColor: color,

),
);



}
}
