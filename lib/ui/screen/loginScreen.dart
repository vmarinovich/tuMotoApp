import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';
import 'package:tu_moto_app/ui/widget/pallete.dart';
import 'package:tu_moto_app/ui/widget/textFieldForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isMale = true;
  bool isSignupScreen = true;
  bool isRememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: <Widget>[
          // Headers
          Positioned(
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
                            text: ' TuMoto',
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
                      isSignupScreen
                          ? 'Registrate para continuar'
                          : 'Ingresa para continuar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          buildButtomMethod(true),

          // Box General
          AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              curve: Curves.decelerate,
              top: isSignupScreen ? 80 : 250,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.decelerate,
                height: isSignupScreen ? 420 : 270,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5),
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          // Tabs Login
                          child: Column(children: [
                            Text('INGRESAR ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignupScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                )),
                            SizedBox(
                              height: 2,
                            ),
                            if (!isSignupScreen)
                              Container(
                                height: 2,
                                width: 30,
                                color: BrandColors.colorBlue,
                              )
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          // Tabs Registrar
                          child: Column(children: [
                            Text('REGISTRARSE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                )),
                            SizedBox(
                              height: 2,
                            ),
                            if (isSignupScreen)
                              Container(
                                height: 2,
                                width: 30,
                                color: BrandColors.colorBlue,
                              )
                          ]),
                        )
                      ],
                    ),

                    /// TextField Form UserName
                    (isSignupScreen)
                        ? buildSignupSection()
                        : buildLoginSection()
                  ],
                ),
              )),
          //Boton submit
          buildButtomMethod(false),
          Positioned(
              top: MediaQuery.of(context).size.height - 80,
              right: 0,
              left: 0,
              child: Column(children: <Widget>[
                Text('O continua con'),
                SizedBox(
                  height: 8,
                ),

                //Boton de Facebook
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildTextButton(MaterialCommunityIcons.facebook,
                          'Facebook', Palette.facebookColor),
                      buildTextButton(MaterialCommunityIcons.google, 'Google',
                          Palette.googleColor),
                    ]),
              ])),
        ],
      ),
    );
  }

  // Formulario de Log In
  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(children: <Widget>[
        buildTextField(Icons.mail_outline, 'info@tumoto.com', false, true),
        SizedBox(
          height: 10,
        ),
        buildTextField(Icons.lock_outline, '*******', false, true),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                      value: isRememberMe,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      }),
                  Text('Recordar',
                      style:
                          TextStyle(fontSize: 12, color: Palette.textColor1)),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('¿Olvidaste tú contraseña?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Palette.textColor1,
                      )))
            ])
      ]),
    );
  }

  // Metodo de formulario
  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          buildTextField(MaterialCommunityIcons.account_outline,
              'Nombre de usuario', false, false),
          SizedBox(
            height: 5,
          ),
          buildTextField(MaterialCommunityIcons.email_outline,
              'Correo electrónico', false, true),
          SizedBox(
            height: 5,
          ),
          buildTextField(MaterialCommunityIcons.phone_classic,
              'Numero de telefono', false, false),
          SizedBox(
            height: 5,
          ),
          buildTextField(
              MaterialCommunityIcons.lock_outline, 'Contraseña', true, false),
          // Selecionar genero
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Palette.textColor2
                                : Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: isMale
                                  ? Colors.transparent
                                  : Palette.textColor2,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text('Hombre',
                          style: TextStyle(color: Palette.textColor1)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: !isMale
                                ? Palette.textColor2
                                : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: !isMale
                                    ? Colors.transparent
                                    : Palette.textColor2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: !isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text('Mujer',
                          style: TextStyle(color: Palette.textColor1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Al aceptar aceptas nuestros ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                        //recognizer: ,
                        text: "terminos & condiciones",
                        style: TextStyle(color: BrandColors.colorBlue))
                  ],
                ),
              ))
        ],
      ),
    );
  }
// Metodo de Construir Boton

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
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
        ]));
  }

  // Metodo Solución para realizar truco de sombras
  Widget buildButtomMethod(bool showShadow) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 700),
        curve: Curves.decelerate,
        top: isSignupScreen ? 454 : 474,
        right: 0,
        left: 0,
        child: Center(
          child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1.5,
                      blurRadius: 10,
                    )
                ]),
            child: !showShadow
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue, BrandColors.colorBlue]),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  )
                : Center(),
          ),
        ));
  }
}
