import 'package:flutter/material.dart';
import 'package:tu_moto_app/ui/widget/pallete.dart';

TextField buildTextField(IconData icon, String hintText, bool isPassword, bool isEmail) {
  return TextField(
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress: TextInputType.text,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Palette.textColor1),
            borderRadius: BorderRadius.all(
                Radius.circular(35)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Palette.textColor1),
            borderRadius: BorderRadius.all(
                Radius.circular(35)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14, color: Palette.textColor1)
      )

  );
}