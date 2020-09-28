import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*
class CustomCard extends StatelessWidget {
  CustomCard({@required this.name, this.contact, this.flat, this.service});

  final name;
  final contact;
  final flat;
  final service;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white30,
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            Text("Service Requester: " + name),
            Text("Contact Info: " + '+91' + contact),
            Text("Flat Number: " + flat),
            Text("Service Required: " + service),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: const Text('CALL'),
                  onPressed: () {
                  },
                ),
                FlatButton(
                  child: const Text('Delete'),
                  onPressed: () async{
                    await FirebaseFirestore.instance.collection('services').doc(.documentID).delete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/