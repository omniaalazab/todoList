import 'package:flutter/material.dart';

import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';

class CreateDialogToaster {
  static Future showErrorDialogDefult(
      String msgTitle, String masgContent, var context) {
    return showPlatformDialog(
        context: context,
        builder: (context) => BasicDialogAlert(
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  msgTitle,
                  style: TextStyleHelper.textStylefontSize22
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              content: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        masgContent,
                        style: TextStyleHelper.textStylefontSize13,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator(
                        color: ColorHelper.mintGreen,
                      ),
                    ],
                  ),
                ),
              ),
            )
        // titlePadding:
        //     const EdgeInsets.only(top: 10),

        );
  }

  static void showDoneDialog(var context, AnimationController doneController) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset("assets/images/Animation - 1726166940390.json",
                    onLoaded: (composition) {
                  doneController.duration = composition.duration;
                  doneController.forward();
                }, controller: doneController, repeat: false),
              ],
            )));
  }

  static void showDeleteDialog(
      var context, AnimationController deleteController) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset("assets/images/Animation - 1726172745763.json",
                    onLoaded: (composition) {
                  deleteController.duration = composition.duration;
                  deleteController.forward();
                }, controller: deleteController, repeat: false),
              ],
            )));
  }

  static void showErrorToast(String msgText) {
    Fluttertoast.showToast(
        msg: msgText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSucessToast(String msgText) {
    Fluttertoast.showToast(
        msg: msgText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: const Color.fromARGB(255, 50, 161, 23),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
