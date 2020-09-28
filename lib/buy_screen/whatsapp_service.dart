import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class WAService extends StatelessWidget{
  final String WAmobile;
  final String message;
  WAService(this.WAmobile,this.message);
  _waService() async{
    String url(){
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$WAmobile/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$WAmobile&text=${Uri.parse(message)}";
      }
    }
    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
    }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: RaisedButton(onPressed: (){_waService();},color: Colors.white,child: const Text('WHATSAPP', style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),))
    );
  }
  }