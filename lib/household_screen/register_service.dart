import 'package:flutter/material.dart';
import 'package:marketplace_aryavarta/household_screen/household_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_service';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                return HouseholdScreen();
              }), ModalRoute.withName(HouseholdScreen.id));
            }),
        title: Text('Service Help Needed'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Add Your Service Request ",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 25,
                      fontFamily: 'Roboto')),
              RegisterService(),
            ]),
      )),
    );
  }
}

class RegisterService extends StatefulWidget {
  @override
  _RegisterServiceState createState() => _RegisterServiceState();
}

class _RegisterServiceState extends State<RegisterService> {
  final _formKey = GlobalKey<FormState>();
  final serviceType = TextEditingController();
  final serviceName = TextEditingController();
  final serviceContact = TextEditingController();
  final serviceFlat = TextEditingController();

  //final dbRef = FirebaseDatabase.instance.reference().child("services");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: serviceName,
              maxLength: 40,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Enter your Name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your Name';
                }
                return null;
              },
            ),
          ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: serviceType,
                  maxLength: 20,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    labelText: "What kind of service do you need?",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your service need';
                    }
                    return null;
                  },
                ),
              ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: serviceContact,
              maxLength: 10,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Enter your mobile number",
                prefixText: '+91',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your mobile number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: serviceFlat,
              maxLength: 7,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Enter your Flat number",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your flat number';
                }
                return null;
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FirebaseFirestore.instance
                            .collection('services')
                            .add({
                              "name": serviceName.text,
                              "contact": '+91' + serviceContact.text,
                              "flatNo": serviceFlat.text,
                              "serviceType": serviceType.text,
                            })
                            .then((result) => {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                    return HouseholdScreen();
                                  }), ModalRoute.withName(HouseholdScreen.id)),
                                  serviceName.clear(),
                                  serviceContact.clear(),
                                  serviceFlat.clear(),
                                  serviceType.clear()
                                })
                            .catchError((err) => print(err))
                            .then((_) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Successfully Added')));
                              serviceName.clear();
                              serviceFlat.clear();
                              serviceContact.clear();
                              serviceType.clear();
                            })
                            .catchError((onError) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(onError)));
                            });
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              )),
        ])));
  }

  @override
  void dispose() {
    super.dispose();
    serviceName.dispose();
    serviceContact.dispose();
    serviceFlat.dispose();
    serviceType.dispose();
  }
}
