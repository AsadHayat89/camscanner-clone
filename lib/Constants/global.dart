import 'dart:io';

import 'package:flutter/material.dart';

import 'Constant.dart';
List<String> catagory=["Household","Utilities","Cars","General","Credit","Card","Legal","Medical","Favourites","Recent","Trash"];
List<File> recently=[];
int logged=0;
String UserID="1";

List<File> taskList=[];
class cat{
  String name;
  Icon icon;
  cat({
    this.icon,
    this.name
});
}
List<cat> catagory1= [
  cat(
    name: "Household",
    icon: Icon(Icons.house,color: catColor)
  ),
  cat(
      name: "Cars",
      icon: Icon(Icons.car_repair,color: catColor,)

  ),
  cat(
      name: "Utilities",
      icon: Icon(Icons.shopping_cart_outlined,color: catColor,)
  ),
  cat(
      name: "General",
      icon: Icon(Icons.ac_unit,color: catColor,)

  ),
  cat(
      name: "Credit",
      icon: Icon(Icons.monetization_on_outlined,color: catColor,)

  ),
  cat(
      name: "Medical",
      icon: Icon(Icons.medical_services,color: catColor,)

  ),
  cat(
      name: "Favourites",
      icon: Icon(Icons.favorite,color: catColor,)

  ),
  cat(
      name: "Reset",
      icon: Icon(Icons.reset_tv,color: catColor,)

  ),
  cat(
      name: "Trash",
      icon: Icon(Icons.transfer_within_a_station,color:catColor ,)

  ),
];