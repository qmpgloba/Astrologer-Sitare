import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String content,Color color){
  return Fluttertoast.showToast(msg: content,backgroundColor: color,);
}