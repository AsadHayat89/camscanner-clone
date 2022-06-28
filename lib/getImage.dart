import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class getImageCont extends StatelessWidget {
  final File amg;
  const getImageCont({key,
    this.amg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: EdgeInsets.all(10),
    //  margin: EdgeInsets.only(top: 10),
            child: amg==null? Text("No data"): Image.file(amg),
          );



  }
}
