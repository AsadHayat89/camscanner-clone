import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_test/FileList.dart';
import 'package:image_picker_test/pdfApi.dart';
import 'package:image_picker_test/Constants/global.dart';
import 'dart:async';
import 'Constants/Constant.dart';
import 'Firebase/Recent.dart';
import 'Firebase/method.dart';
import 'Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
      ),
    ),
  ));
}


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
var files;
var _count = 0;
var _tapPosition;
int index;
@override
void initState(){

  super.initState();
}

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
                  FlatButton(
                      onPressed: () {
                        catagory1.removeAt(index1);
                        Navigator.pop(context);
                        (context as Element).reassemble();
                      },
                      child:Row(
                        children: [
                          Icon(Icons.delete),
                          Text("  "),
                          Text("Delete"),
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
    final Size size = MediaQuery.of(context).size;
    //getFiles();
    return Scaffold(
      backgroundColor: backgroundColor,
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
          final pdfFile =await PdfApi.CreateDirectrybyList(catagory1);
            },
              icon: Icon(Icons.email,
                  color: iconColor
              ))
        ],
      ),
      body:Center(
        child:ListView.builder(
          
          //if file/folder list is grabbed, then show here
          itemCount: catagory1?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: (){
                _showCustomMenu(index);
              },

              onTapDown: _storePosition,

              child: Card(

                color: boxColor,
                  child:ListTile(

                    title: Text(catagory1[index].name,style: TextStyle(
                        color: TextColor
                    ),),
                    leading: catagory1[index].icon,


                    trailing: Icon(Icons.arrow_forward, color: Colors.redAccent,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return FileList(dirc:catagory1[index].name);
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
