import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';

class GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,

      // Header Background con imagen
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backImage.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 90, left: 20),
          color: BrandColors.colorblue.withOpacity(.80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      text: 'Bienvenido a',
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                      children: [
                    TextSpan(
                      text: ' Tu Moto',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ingresa para continuar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
