import 'dart:async';
import 'dart:io';

import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_test/Catagories.dart';
import 'package:image_picker_test/getImage.dart';
import 'package:image_picker_test/pdfApi.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

import 'Constants/Constant.dart';
import 'main.dart';




class tryFilter extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<tryFilter> {
String fileName;
  XFile imageFile;
  String fileName2="fileName";
  List<File> img=[];
  
  List<Filter> filters = presetFiltersList;
  
  File cropped;


Future<File> Cropped(XFile filedata,context) async{
  cropped = await ImageCropper.cropImage( sourcePath: filedata.path,
      aspectRatioPresets: Platform.isAndroid
      ? [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
      ]
      : [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
      ],
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: color,
        toolbarTitle: "RPS Cropper",
        statusBarColor: TextColor,
        backgroundColor: color,
      )
  );
  applyfilter(cropped, context);
}

Future<File> applyfilter(File filedata,context) async{
  fileName = basename(cropped.path);
  var image = imageLib.decodeImage(cropped.readAsBytesSync());
  image = imageLib.copyResize(image, width: 600);
  Map imagefile = await Navigator.push(
    context,
    new MaterialPageRoute(
      builder: (context) => new PhotoFilterSelector(
        title: Text("Photo Filter Example",style: TextStyle(color: TextColor),),
        image: image,
        filters: presetFiltersList,
        filename: fileName,
        loader: Center(child: CircularProgressIndicator()),
        fit: BoxFit.contain,
        appBarColor: color,
      ),
    ),
  );
  this.setState(() {
    img.add(imagefile['image_filtered']);
    print(img.length);
    //img.insert(0, this.imageFile);
    // AddImage(this.imageFile);
  });
  if (imagefile != null && imagefile.containsKey('image_filtered')) {
    setState(() {
      imageFile = imagefile['image_filtered'];
      // AddImage(imagefile);
    });
    //  print(imageFile.path);
  }
}
  Future<File> getImageCamera(context) async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    //croping
    if(imageFile != null){
      //print("Entet");
      Cropped(imageFile,context);
    }

  }
Future<File> getImagegalerry(context) async {
  imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //croping
  if(imageFile != null){
    //print("Entet");
    Cropped(imageFile,context);
  }

}
var _tapPosition;
int variableSet = 0;
ScrollController _scrollController;
double width;
double height;

  @override
  Widget build(BuildContext context) {
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
                      img.removeAt(index1);
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
  void showDialogWithFields() {
      showDialog(
        context: context,
        builder: (_) {
          var Name = TextEditingController();
        //  var messageController = TextEditingController();
          return AlertDialog(
            title: Text('Enter File Name'),
            content: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: Name,
                  decoration: InputDecoration(hintText: 'FileName'),
                ),

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
                  fileName2=name;
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

    final Size size = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: backgroundColor,
      appBar: new AppBar(
        title: new Text('Photo Filter Example',style: TextStyle(color: TextColor),),
        leading:IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Home()));
          },
          icon:Icon(Icons.arrow_back_outlined,
            color: iconColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed:showDialogWithFields,
              icon: Icon(Icons.list,
                color: iconColor,

              )
          ),
          IconButton(onPressed: () {
            print("before sending"+img.length.toString());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => catagorydata2(img2:img,filename: fileName2)));
          },
              icon: Icon(Icons.picture_as_pdf,
                  color: iconColor
              ))
        ],
      backgroundColor:color,
      ),
      body: DragAndDropGridView(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4.5,
          ),
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index){
          return GestureDetector(

                  onDoubleTap:(){
                    _showCustomMenu(index);
                  },
                  onTapDown: _storePosition,

                  child: Container(
                    //height: 200,
                       //width: 400,
                       child:  getImageCont(amg:img[index]),
                  ),
                );
                //child: getImageCont(amg:img[index]),
              },
          itemCount: img.length,
          onWillAccept: (oldIndex, newIndex) {
            if (img[newIndex] == "something") {
              return false;
            }
            return true;
          },
          onReorder: (oldIndex, newIndex) {
            final temp = img[oldIndex];
            img[oldIndex] = img[newIndex];
            img[newIndex] = temp;

            setState(() {});
          },
    ),
    //itemCount: img.length,






      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed:(){
                  getImageCamera(context);
                },

                child: Icon(

                  Icons.camera_alt,
                ),

                backgroundColor: color,
              ),
            ),

            FloatingActionButton(
              heroTag: "btn2",
              onPressed: (){
                getImagegalerry(context);
              },
              child: Image.asset("assests/gallery.png",color: Colors.white,),
              backgroundColor: color,
            ),
          ],
        ),
      ),

    );

  }

}
