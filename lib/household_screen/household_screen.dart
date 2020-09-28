import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_aryavarta/household_screen/register_service.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';
import 'package:marketplace_aryavarta/buy_screen/call_service.dart';

class HouseholdScreen extends StatefulWidget {
  static const String id = 'household_screen';

  @override
  _HouseholdScreenState createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
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
        title: Text('SERVICE HELP NEEDED'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('services').snapshots(),
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
                          elevation: 20.0,
                          color: Colors.orangeAccent,
                          child: Container(
                            color: Colors.white30,
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Service Requester: " + doc.get('name'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Flat Number: " + doc.get('flatNo'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Service Required: " + doc.get('serviceType'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CallService('tel:' + doc.get('contact')),
                                    FlatButton(
                                      child: const Text('Delete'),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text(
                                                  "Do you want to delete requested service?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No, Cancel')),
                                                FlatButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'services')
                                                          .doc(doc.id)
                                                          .delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'))
                                              ],
                                            ));
                                      },
                                    ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, RegisterScreen.id);
        },
        icon: Icon(Icons.add),
        label: Text("Add Request"),
        backgroundColor: Colors.orange,
      ),
    );
  }
}