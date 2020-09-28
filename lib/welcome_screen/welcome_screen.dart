import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_aryavarta/shops_screen/shops_screen.dart';
import 'package:marketplace_aryavarta/welcome_screen/rounded_button.dart';
import 'package:marketplace_aryavarta/buy_screen/buy_screen.dart';
import 'package:marketplace_aryavarta/household_screen/household_screen.dart';
import 'package:marketplace_aryavarta/login_screen/login_page.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  final memberMobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Image.asset('images/Logo_AMP.png'),
                height: 200,
              ),
              SizedBox(
                height: 36.0,
              ),
              RoundedButton(
                title: 'BUY',
                colour: Color(0xFFFF962F),
                onPressed: () {
                  Navigator.pushNamed(context, BuyScreen.id);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                title: 'SELL',
                colour: Color(0xFFFF962F),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                title: 'SERVICE HELP NEEDED',
                colour: Color(0xFFFF962F),
                onPressed: () {
                  Navigator.pushNamed(context, HouseholdScreen.id);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                title: 'SHOPS NEAR ME',
                colour: Color(0xFFFF962F),
                onPressed: () {
                  Navigator.pushNamed(context, ShopsScreen.id);
                },
              ),
            ],
          ),
        ),
      persistentFooterButtons: <Widget>[
        Text('DEVELOPED BY SHASHWAT H KAKKAD', style: TextStyle(fontSize: 10.0))
      ],
    );
  }
}
