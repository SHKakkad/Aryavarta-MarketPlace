import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marketplace_aryavarta/household_screen/register_service.dart';
import 'package:marketplace_aryavarta/login_screen/login_page.dart';
import 'package:marketplace_aryavarta/sell_screen/sell_register.dart';
import 'package:marketplace_aryavarta/shops_screen/shops_screen.dart';
import 'package:marketplace_aryavarta/welcome_screen/welcome_screen.dart';
import 'package:marketplace_aryavarta/buy_screen/buy_screen.dart';
import 'package:marketplace_aryavarta/household_screen/household_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        BuyScreen.id: (context) => BuyScreen(),
        LoginPage.id: (context) => LoginPage(),
        HouseholdScreen.id: (context) => HouseholdScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        SellRegisterScreen.id: (context) => SellRegisterScreen(),
        ShopsScreen.id: (context) => ShopsScreen()
      },
    );
  }
}
