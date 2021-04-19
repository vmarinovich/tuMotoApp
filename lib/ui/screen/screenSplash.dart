import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/screen/loginScreen.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';


class ScreenSplash extends StatefulWidget {
  static const String id = 'ScreenSplash';


  @override
  _ScreenSplashState createState() => _ScreenSplashState('image','tile','parrafo');
}

class _ScreenSplashState extends State<ScreenSplash> {
  final String image;
  final String tile;
  final String parrafo;

  _ScreenSplashState(this.image, this.tile, this.parrafo);

  bool last = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(


        color: Colors.white,
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              Image(
                  alignment: Alignment.center,
                  height: 250.0,
                  width: 250.0,
                  image: AssetImage(image)
              ),

              SizedBox(height: 50,),
              Text(tile,
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Brand-Regular',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25,),
              Text(parrafo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Brand-Regular',
                    color: BrandColors.colorDimText,)

              ),
              SizedBox(height: 55,),

              GestureDetector(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                },
                child: Container(

                  margin: EdgeInsets.all(0),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),



                  ),
                    child: Center(
                      widthFactor: 10,
                      child: Text('Saltar', style: TextStyle(
                        fontSize: 18, decoration: TextDecoration.underline,
                      color: Colors.black,),),
                    ),


                ),
              )
            ]
        ),
      ),
    );
  }
}

TextButton buildTextButton(
    IconData icon, String title, Color backgroundColor) {
  //Metodo LoginAuthUser

  return TextButton(
      onPressed: () {},
  style: TextButton.styleFrom(
  minimumSize: Size(145, 40),
  shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  backgroundColor: backgroundColor),
  child: Row(children: <Widget>[
  Icon(icon, color: Colors.white),
  SizedBox(width: 5),
  Text(title, style: TextStyle(color: Colors.white))
  ]
  )
  );
}