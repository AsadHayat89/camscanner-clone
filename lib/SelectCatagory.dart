import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:image_picker_test/FileList.dart';
import 'package:image_picker_test/pdfApi.dart';
import 'package:image_picker_test/Constants/global.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker_test/tryFilter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class SelectCat extends StatefulWidget {
  const SelectCat({Key key}) : super(key: key);

  @override
  _SelectCatState createState() => _SelectCatState();
}

class _SelectCatState extends State<SelectCat> {
  double kDefaultPaddin=20.0;
 // List<String> categories = ["Hand bag", "Jewellery", "Footwear", "Dresses"];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catagory.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              catagory[index],
              style: TextStyle(

                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.black : Colors.black45,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}