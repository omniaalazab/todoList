import 'package:flutter/material.dart';
import 'package:todolist/helper/color_helper.dart';

import 'package:todolist/helper/text_style_helper.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.textHint,
    required this.textController,
    required this.textFieldSuffix,
    required this.validatorFunction,
    this.onChangedFunction,
    this.textFieldPrefix = const SizedBox(
      width: 1,
    ),
    this.isObsecure = false,
    this.keyboardType = TextInputType.text,
  });
  TextEditingController textController;
  Widget? textFieldSuffix;
  Widget? textFieldPrefix;
  String textHint;
  final TextInputType keyboardType;
  final String? Function(String?)? validatorFunction;
  Function(String)? onChangedFunction;
  bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: textController,
        obscureText: isObsecure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: ColorHelper.white,
          prefixIcon: textFieldPrefix,
          hintText: textHint,
          hintStyle: TextStyleHelper.textStylefontSize14,
          suffixIcon: textFieldSuffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(
            //   color: ColorHelper.purple,
            //   width: 1,
            // ),
          ),
          enabledBorder: InputBorder.none,
        ),
        validator: validatorFunction,
        onChanged: onChangedFunction,
      ),
    );
  }
}
