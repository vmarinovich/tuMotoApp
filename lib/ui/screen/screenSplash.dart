
import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/screen/loginScreen.dart';

class ScreenSplash extends StatelessWidget {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//We take the image from the assets
                Image.asset(
                  'assets/images/Splashscreen.png',
                  height: 250,
        ),
               SizedBox(
                height: 20,
        ),
//Texts and Styling of them
               Text(
                'Bienvenido a Tu Moto',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
                      SizedBox(height: 20),
                      Text(
                        'Ingresa ahora y consigue una moto que te lleve a donde quieras',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
        ),
              SizedBox(
                height: 30,
        ),
//Our MaterialButton which when pressed will take us to a new screen named as
//LoginScreen
              MaterialButton(
                elevation: 0,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
                color: logoGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Ingresar',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                textColor: Colors.white,
        )
      ],
    ))
    );
  }
}
