import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_aryavarta/buy_screen/buy_screen.dart';
import 'package:marketplace_aryavarta/login_screen/sign_in.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SellRegisterScreen extends StatefulWidget {
  static const String id = 'sell_register';

  @override
  _SellRegisterScreenState createState() => _SellRegisterScreenState();
}

class _SellRegisterScreenState extends State<SellRegisterScreen> {
  final sellerid = userid.substring(0, 6);

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
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text("Are you sure you want to Log Out?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No, Cancel')),
                      FlatButton(
                          onPressed: () {
                            signOutGoogle();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return WelcomeScreen();
                            }), ModalRoute.withName(WelcomeScreen.id));
                          },
                          child: Text('Yes'))
                    ],
                  ));
            },
            child: Text('Log Out'),
            textColor: Colors.white,
          )
        ],
        title: Text('Your Product/Service'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hello " + name + "!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic)),
              SizedBox(
                height: 8.0,
              ),
              Text("Your Unique Product ID:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic)),
              Text(sellerid,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
              SizedBox(
                height: 8.0,
              ),
              Text("Register Your new Product/Service ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic)),
              SellRegisterService(),
            ]),
      )),
    );
  }
}

class SellRegisterService extends StatefulWidget {
  @override
  _SellRegisterServiceState createState() => _SellRegisterServiceState();
}

class _SellRegisterServiceState extends State<SellRegisterService> {
  File _imageFile;
  final picker = ImagePicker();
  String fileName;
  String productImage;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    fileName = basename(_imageFile.path);
    productImage = sellerName.text + '-' + productName.text + '-' + selleruid + fileName;
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$productImage');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  final selleruid = userid.substring(0, 6);
  final _formKey = GlobalKey<FormState>();
  final sellerName = TextEditingController();
  final sellerContact = TextEditingController();
  final sellerWAContact = TextEditingController();
  final sellerFlat = TextEditingController();
  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final offerValid = TextEditingController();
  final sellerlink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: productName,
              maxLength: 50,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Enter your product/service name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your product/service name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              maxLength: 200,
              maxLengthEnforced: true,
              controller: productDescription,
              decoration: InputDecoration(
                labelText: "Describe your product/service",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your product/service description';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: sellerlink,
              decoration: InputDecoration(
                labelText:
                    "Enter website/google drive link for your product/service",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              controller: offerValid,
              maxLength: 8,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Offer Valid till dd/mm/yy: ",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Your Product/Service is offered till what date?';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              controller: sellerName,
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
              keyboardType: TextInputType.phone,
              controller: sellerContact,
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
              keyboardType: TextInputType.phone,
              controller: sellerWAContact,
              maxLength: 10,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: "Enter Your WhatsApp number",
                prefixText: '+91',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Your WhatsApp number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: sellerFlat,
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
            child: Text(
              'Select a picture of your product:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: _imageFile != null
                      ? Image.file(_imageFile)
                      : FlatButton(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                          onPressed: pickImage,
                        ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (_imageFile != null) {
                          uploadImageToFirebase(context);
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('Please confirm your submission'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () async {
                                        final ref = FirebaseStorage.instance
                                            .ref()
                                            .child('$productImage');
                                        var url = await ref.getDownloadURL();
                                        print(url);
                                        FirebaseFirestore.instance
                                            .collection('buy_products')
                                            .add({
                                              "selleruid": selleruid,
                                              "imageurl": url.toString(),
                                              "name": sellerName.text,
                                              "mobileno":
                                                  '+91' + sellerContact.text,
                                              "WAmobileno":
                                                  '+91' + sellerWAContact.text,
                                              "flatNo": sellerFlat.text,
                                              "offervalid": offerValid.text,
                                              "title": productName.text,
                                              "sellerlink": sellerlink.text,
                                              "description":
                                                  productDescription.text,
                                            })
                                            .then((result) => {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                    return BuyScreen();
                                                  }),
                                                          ModalRoute.withName(
                                                              BuyScreen.id)),
                                                  sellerName.clear(),
                                                  sellerFlat.clear(),
                                                  sellerContact.clear(),
                                                  sellerWAContact.clear(),
                                                  offerValid.clear(),
                                                  productName.clear(),
                                                  productDescription.clear(),
                                                  sellerlink.clear(),
                                                })
                                            .catchError((err) => print(err))
                                            .then((_) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Successfully Added')));
                                              sellerName.clear();
                                              sellerFlat.clear();
                                              sellerContact.clear();
                                              sellerWAContact.clear();
                                              offerValid.clear();
                                              productName.clear();
                                              productDescription.clear();
                                              sellerlink.clear();
                                            })
                                            .catchError((onError) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(onError)));
                                            });
                                      },
                                      child: Text('CONFIRM'))
                                ],
                              ));
                        } else {
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text('Please confirm your submission'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection('buy_products')
                                            .add({
                                              "selleruid": selleruid,
                                              "imageurl": 'null',
                                              "name": sellerName.text,
                                              "mobileno":
                                                  '+91' + sellerContact.text,
                                              "WAmobileno":
                                                  '+91' + sellerWAContact.text,
                                              "flatNo": sellerFlat.text,
                                              "offervalid": offerValid.text,
                                              "title": productName.text,
                                              "sellerlink": sellerlink.text,
                                              "description":
                                                  productDescription.text,
                                            })
                                            .then((result) => {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                    return BuyScreen();
                                                  }),
                                                          ModalRoute.withName(
                                                              BuyScreen.id)),
                                                  sellerName.clear(),
                                                  sellerFlat.clear(),
                                                  sellerContact.clear(),
                                                  sellerWAContact.clear(),
                                                  offerValid.clear(),
                                                  productName.clear(),
                                                  productDescription.clear(),
                                                  sellerlink.clear(),
                                                })
                                            .catchError((err) => print(err))
                                            .then((_) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Successfully Added')));
                                              sellerName.clear();
                                              sellerFlat.clear();
                                              sellerContact.clear();
                                              sellerWAContact.clear();
                                              offerValid.clear();
                                              productName.clear();
                                              productDescription.clear();
                                              sellerlink.clear();
                                            })
                                            .catchError((onError) {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(onError)));
                                            });
                                      },
                                      child: Text('CONFIRM'))
                                ],
                              ));
                        }
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
    sellerName.dispose();
    sellerFlat.dispose();
    sellerContact.dispose();
    offerValid.dispose();
    productName.dispose();
    productDescription.dispose();
    sellerlink.dispose();
    sellerWAContact.dispose();
  }
}
