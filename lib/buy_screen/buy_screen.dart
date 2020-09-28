import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';
import 'package:marketplace_aryavarta/buy_screen/Hyperlink.dart';
import 'package:marketplace_aryavarta/buy_screen/call_service.dart';
import 'package:marketplace_aryavarta/buy_screen/whatsapp_service.dart';

class BuyScreen extends StatefulWidget {
  static const String id = 'buy_screen';

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<Map<dynamic, dynamic>> lists = [];
  String imageurl;
  String sellerlink;
  String selleruid;
  String mobileno;
  String WAmobileno;
  final selleruidtext = TextEditingController();

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
        title: Text('Aryavarta MarketPlace'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('buy_products')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.docs.map((buydoc) {
                        imageurl = buydoc.get('imageurl');
                        sellerlink = buydoc.get('sellerlink');
                        selleruid = buydoc.get('selleruid');
                        mobileno = buydoc.get('mobileno');
                        WAmobileno = buydoc.get('WAmobileno');
                        return new Card(
                          color: Colors.orangeAccent,
                          child: Container(
                            color: Colors.white30,
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Column(
                              children: <Widget>[
                                Text(buydoc.get('title'),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                        child: imageurl != 'null'
                                            ? Image.network(imageurl)
                                            : Text('--------------------'),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  buydoc.get('description'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Offer valid till date: " +
                                      buydoc.get('offervalid'),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Offered by: " + buydoc.get('name'),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(buydoc.get('flatNo'),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(2.0),
                                child: sellerlink != ""?Hyperlink(sellerlink, 'TAP HERE FOR MORE INFORMATION'):Text('')),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CallService('tel:' + mobileno),
                                    WAService(WAmobileno, 'Hi '+ buydoc.get('name') +"!" +'\nI came across your product in Aryavarta MarketPlace! I would like to know more...'),
                                    FlatButton(
                                      child: const Text('Delete'),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text(
                                                  "Do you want to delete following product/service?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No, Cancel')),
                                                FlatButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        child: AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          content: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  'Please Enter your Unique Product ID to confirm deletion of your product/service:'),
                                                              Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                autofocus: true,
                                                                maxLength: 6,
                                                                maxLengthEnforced:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                        labelText:
                                                                            'Enter your 6-character Unique Product ID'),
                                                                controller:
                                                                    selleruidtext,
                                                              )),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pushAndRemoveUntil(
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return BuyScreen();
                                                                  }),
                                                                      ModalRoute.withName(
                                                                          BuyScreen
                                                                              .id));
                                                                },
                                                                child: Text(
                                                                    'Cancel')),
                                                            FlatButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (selleruidtext
                                                                          .text ==
                                                                      selleruid) {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'buy_products')
                                                                        .doc(buydoc
                                                                            .id)
                                                                        .delete();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushAndRemoveUntil(MaterialPageRoute(builder:
                                                                            (context) {
                                                                      return BuyScreen();
                                                                    }), ModalRoute.withName(BuyScreen.id));
                                                                  } else {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              Text('Wrong Unique Product ID. Cannot delete the product/service'),
                                                                          actions: <
                                                                              Widget>[
                                                                            FlatButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                                                                                    return BuyScreen();
                                                                                  }), ModalRoute.withName(BuyScreen.id));
                                                                                },
                                                                                child: Text('Ok'))
                                                                          ],
                                                                        ));
                                                                  }
                                                                },
                                                                child: Text(
                                                                    'Yes, Confirm'))
                                                          ],
                                                        ),
                                                      );
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
    );
  }
}
