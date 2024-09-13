import 'package:flutter/material.dart';
import 'package:todolist/helper/text_style_helper.dart';
import 'package:todolist/ui/screens/authentication/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  double opacity = 0;
  startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1;
      });
    });
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    width: 150,
                    height: 200,
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/todo.png")),
                Text("Get things done with TODo",
                    style: TextStyleHelper.textStylefontSize20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
