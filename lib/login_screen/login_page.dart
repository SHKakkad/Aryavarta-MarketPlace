import 'package:flutter/material.dart';
import 'package:marketplace_aryavarta/login_screen/sign_in.dart';
import 'package:marketplace_aryavarta/sell_screen/sell_register.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<bool> _loginUser() async {
    final api = await signInWithGoogle();
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return WelcomeScreen();
                    }), ModalRoute.withName(WelcomeScreen.id));
              }),
        title: Text('Login Page'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _isLoading ? CircularProgressIndicator() : Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        /*signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SellRegisterScreen();
                },
              ),
            );
          }
        });*/
        setState(() => _isLoading = true);
        bool b = await _loginUser();
        setState(() => _isLoading = false);
        if (b == true) {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new SellRegisterScreen();
              }));
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
