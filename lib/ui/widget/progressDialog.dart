import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';

// ignore: must_be_immutable
class ProgressDialog extends StatelessWidget {

  String message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: Container(
        margin: EdgeInsets.all((15.0)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 2,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),),
            SizedBox(width: 26,),
            Text(
              message,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        ),
      );
  }
}
