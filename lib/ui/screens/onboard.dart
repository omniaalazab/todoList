import 'package:flutter/material.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';
import 'package:todolist/ui/screens/todo_task.dart';
import 'package:todolist/ui/widget/shared_widget/custom_elevated_button.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Welcome Onboard!",
                style: TextStyleHelper.textStylefontSize20),
            const Image(
              height: 200,
              width: 180,
              image: AssetImage("assets/images/onboard.png"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Text("Add What your want to do later on..",
                  style: TextStyleHelper.textStylefontSize13),
            ),
            CustomElevatedButton(
                buttonText: "Add to List",
                onPressedFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ToDoTask()));
                },
                backColor: ColorHelper.mintGreen,
                fontColor: ColorHelper.white)
          ],
        ),
      ),
    );
  }
}
