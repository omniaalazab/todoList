import 'package:flutter/material.dart';

import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';

// ignore: must_be_immutable
class SignUpOrSignInRow extends StatelessWidget {
  SignUpOrSignInRow({
    required this.textRow,
    required this.textButtonText,
    required this.onPressedFunction,
    super.key,
  });
  String textRow;
  String textButtonText;
  void Function()? onPressedFunction;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textRow, style: TextStyleHelper.textStylefontSize14),
        TextButton(
            onPressed: onPressedFunction,
            child: Text(textButtonText,
                style: TextStyleHelper.textStylefontSize14
                    .copyWith(color: ColorHelper.mintGreen))),
      ],
    );
  }
}
