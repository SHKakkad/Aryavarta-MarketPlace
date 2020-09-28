import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String _url;
  final String _text;

  Hyperlink(this._url, this._text);

  _launchURL() async {
    if (await canLaunch(_url)) {
      await launch(_url,
      forceWebView: true,
      enableJavaScript: true);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FlatButton(onPressed: (){_launchURL();}, child: Text('TAP HERE FOR MORE INFORMATION',style: TextStyle(color: Colors.indigo,fontSize: 15.0),))
    );
  }
}