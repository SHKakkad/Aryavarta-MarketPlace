import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';
import 'package:marketplace_aryavarta/buy_screen/call_service.dart';

class ShopsScreen extends StatefulWidget {
  static const String id = 'shops_screen';

  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}
class _ShopsScreenState extends State<ShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return WelcomeScreen();
                  }), ModalRoute.withName(WelcomeScreen.id));
            }),
        title: Text('SHOPS NEAR ME'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance.collection('shops').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.docs.map((doc) {
                        return Card(
                          elevation: 15.0,
                          color: Colors.orangeAccent,
                          child: Container(
                            color: Colors.white30,
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Column(
                              children: <Widget>[
                                Text(doc.get('name'),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(doc.get('type'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CallService('tel:' + doc.get('contact')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
    );
  }
}