import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/screen/loginScreen.dart';
import 'package:tu_moto_app/ui/screen/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
      initialRoute: MainPage.id,
      routes: {
        LoginScreen.id: (context)=> LoginScreen(),
        MainPage.id: (context)=> MainPage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
