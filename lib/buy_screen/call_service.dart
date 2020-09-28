import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallService extends StatelessWidget {
  final String _mobile;
  CallService(this._mobile);
  _callPhone() async {
    if (await canLaunch(_mobile)) {
      await launch(_mobile);
    } else {
      throw 'Could not Call Phone';
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RaisedButton(onPressed: (){_callPhone();}, child: Text('CALL', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),color: Colors.white,)
    );
  }

}