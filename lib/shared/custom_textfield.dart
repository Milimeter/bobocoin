import 'package:flutter/material.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';

class AuthTextField extends StatelessWidget {
  //final Function(String) validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String error;
  final String Function(String?) validFunction;
  final Function(String)? onSavedFunction;
  final Function(String)? onSubmitFunction; 
  final Color? color;
  final bool? enabled;
  final double? height;
  const AuthTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.error,
    required this.validFunction,
    this.onSavedFunction,
    this.color,
    this.onSubmitFunction,
    this.enabled = true,
    this.height,
    //required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: heightSize(height ?? 55),
      width: size.width,
      decoration: BoxDecoration(
          color: color ?? kBackgroundColor,
          borderRadius: BorderRadius.circular(Values().boxRadius2),
          border: Border.all(color: kPrimaryColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            validator: validFunction,
            onChanged: onSavedFunction,
            onFieldSubmitted: onSubmitFunction,
            keyboardType: inputType,
            showCursor: true,
            cursorColor: kTextColor,
            //validator: validator,
            style: TextStyle(
              color: kTextColor,
              fontSize: fontSize(14),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: kText2Color,
                fontSize: fontSize(14),
              ),

              // hintStyle: GoogleFonts.sansita(
              //   color: kWhite,
              // ),

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
