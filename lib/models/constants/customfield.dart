// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/myfonts.dart';

class Custom_Field extends StatelessWidget {
  final TextEditingController controller;
  String labelText;
  String hintText;
  bool isreadonly;
  bool showstar;
  bool isnumber;

  Function(String)? onChanged;
  String? Function(String?)? validate;

  Custom_Field(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.isreadonly,
      required this.showstar,
      required this.isnumber,
      this.onChanged,
      this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isreadonly,
      onChanged: onChanged,
      controller: controller,
      validator: validate,
      style: TextStyle(fontFamily: AppFonts.medium),
      keyboardType: isnumber ? TextInputType.number : null,
      decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: "$hintText",
          hintStyle: TextStyle(fontFamily: AppFonts.regular),
          labelStyle: TextStyle(
              color:AppColors.black, height: 0.8, fontFamily: AppFonts.regular
              // background: Paint
              ),
          contentPadding: EdgeInsets.only(left: 14, bottom: 8, top: 8),
          fillColor: Colors.grey[250],
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.7)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.7)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.7)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.7))),
    );
  }
}
