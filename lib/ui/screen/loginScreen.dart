import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tu_moto_app/ui/screen/mainPage.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';
import 'package:tu_moto_app/ui/widget/pallete.dart';
import 'package:tu_moto_app/ui/widget/progressDialog.dart';
import 'package:tu_moto_app/ui/widget/textFieldForm.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  bool isMale = true;
  bool isSignupScreen = false;
  bool isRememberMe = true;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController numeroTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
              duration: Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
              top: isSignupScreen ? 80 : 250,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
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
                child: SingleChildScrollView(
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
                ),
              )),
          //Boton submit
          buildButtomMethod(false),
          Positioned(
              top: MediaQuery.of(context).size.height - 90,
              right: 0,
              left: 0,
              child: Column(children: <Widget>[
                Text(isSignupScreen ? 'Registrate con' : 'Inicia sesión con '),
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
// Metodo para registrar nuevo usuario

  // ignore: non_constant_identifier_names
  final FirebaseAuth _FirebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: 'Espera unos segundos más',);
          });
    final User firebaseUser =
        (await _FirebaseAuth.createUserWithEmailAndPassword(
                    email: emailTextEditingController.text,
                    password: passwordTextEditingController.text)
                .catchError((errMsg) {
                  Navigator.pop(context);
      displayToastMessage('Error: ' + errMsg.toString(), context);
    }))
            .user;
    if (firebaseUser != null) {
      // Guardar información de usuario
      Map userDataMap = {
        'name': nameTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
        'phone': numeroTextEditingController.text.trim(),
      };

      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          'Felicidades. Tu ha cuenta sido creada satisfactoriamente', context);
      //Navigator.pushNamedAndRemoveUntil(
      //  context, MainPage.idScreen, (route) => false);
    } else {
      // Mostrar mensaje de error
      Navigator.pop(context);
      displayToastMessage('Tu cuenta NO ha sido creada', context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }

  // Metodo LoginAuthUser
  void loginAuthUser(BuildContext context) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: 'Espera unos segundos más',);
        }


    );

    final User firebaseUser = (await _FirebaseAuth.signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage('Error: ' + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
          displayToastMessage('¡Listo calisto!', context);
        }
        else
          {
            Navigator.pop(context);
            _FirebaseAuth.signOut();
            displayToastMessage('No existe un usuario con esta cuenta, pero puedes crear una', context);
          }
      });
    }
    else
    {
      {
        Navigator.pop(context);
        displayToastMessage('Un error ha ocurrido, intenta de nuevo en unos minutos', context);
      }
      ;
    }
  }

  // Formulario de Log In
  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(children: <Widget>[
        buildTextField(emailTextEditingController, Icons.mail_outline,
            'info@tumoto.com', false, true),
        SizedBox(
          height: 10,
        ),
        buildTextField(passwordTextEditingController, Icons.lock_outline,
            '*******', false, true),
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
          buildTextField(
              nameTextEditingController,
              MaterialCommunityIcons.account_outline,
              'Nombre de usuario',
              false,
              false),
          SizedBox(
            height: 5,
          ),
          buildTextField(
              emailTextEditingController,
              MaterialCommunityIcons.email_outline,
              'Correo electrónico',
              false,
              true),
          SizedBox(
            height: 5,
          ),
          buildTextField(
              numeroTextEditingController,
              MaterialCommunityIcons.phone_classic,
              'Numero de telefono',
              false,
              false),
          SizedBox(
            height: 5,
          ),
          buildTextField(passwordTextEditingController,
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
              width: 220,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Al aceptar estas de acuerdo con nuestros ",
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
        ]));
  }

  // Metodo Solución para realizar truco de sombras
  Widget buildButtomMethod(bool showShadow) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
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
            //Boton sign up & log in
            child: isSignupScreen ? GestureDetector(
              onTap: () {
                if (nameTextEditingController.text.length < 4) {
                  Fluttertoast.showToast(
                      msg: 'Tu nombre debe tener al menos 4 caracteres');
                } else if (!emailTextEditingController.text.contains('@')) {
                  Fluttertoast.showToast(
                      msg: 'Correo electrónico invalido');
                } else if (numeroTextEditingController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Ingresa un número de telefono valido');
                } else if (passwordTextEditingController.text.length < 7) {
                  Fluttertoast.showToast(
                      msg: 'Tu contraseña debe tener al menos 8 caracteres');
                } else {

                      registerNewUser(context);

                }
              },
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
            ) : GestureDetector(
              onTap: () {

               if (!emailTextEditingController.text.contains('@')) {
                  Fluttertoast.showToast(
                      msg: 'Correo electrónico invalido');

                } else if (passwordTextEditingController.text.length < 7) {
                  Fluttertoast.showToast(
                      msg: 'Tu contraseña es invalida');
                } else {
                      // ignore: unnecessary_statements
                      loginAuthUser(context); //loginUser(context);
                }
              },
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
            )  ,
          ),
        ));
  }
}
