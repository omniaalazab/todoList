import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/login/login_cubit.dart';
import 'package:todolist/controller/cubit/login/login_state.dart';
import 'package:todolist/controller/cubit/remember/remember_cubit.dart';
import 'package:todolist/controller/functions/check_empty_validation.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';

import 'package:todolist/model/user_model.dart';
import 'package:todolist/ui/screens/authentication/registeration.dart';
import 'package:todolist/ui/screens/onboard.dart';
import 'package:todolist/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:todolist/ui/widget/shared_widget/dailog_toaster.dart';
import 'package:todolist/ui/widget/signin_signout_row.dart';
import 'package:todolist/ui/widget/shared_widget/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isObsecurePass = true;
  bool isObsecureConfirmPass = true;

  bool isRemembered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(),
        ),
        BlocProvider<RememberCubit>(
          create: (_) => RememberCubit(),
        ),
      ],
      child: BlocListener<RememberCubit, RememberState>(
        listener: (context, state) {
          if (state is InitialRemember) {
            setState(() {
              isRemembered = state.isRemember;
              emailController.text = state.email;
              passwordController.text = state.password;
            });
            log("InitialRemember state: email=${state.email}, password=${state.password}");
          } else if (state is ChangeRemmber) {
            setState(() {
              isRemembered = state.isRemember;
            });
            log("ChangeRemember state: isRemember=${state.isRemember}");
          }
        },
        child: BlocConsumer<LoginCubit, LoginStatus>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OnBoard()),
              );
            } else if (state is LoginFailure) {
              CreateDialogToaster.showErrorToast(state.errorMessage);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                child: Form(
                  key: formState,
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
                        height: 20,
                      ),
                      Text("Welcome Back!",
                          style: TextStyleHelper.textStylefontSize20),
                      const Image(
                          height: 216,
                          width: 200,
                          image: AssetImage("assets/images/login.png")),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        textController: emailController,
                        textFieldSuffix: Icon(
                          Icons.mail_outlined,
                          color: ColorHelper.darkgrey,
                        ),
                        textHint: "Enter your Email address ",
                        keyboardType: TextInputType.emailAddress,
                        validatorFunction: (value) {
                          CheckEmptyValidationTextField.checkIsEmpty(value);
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        isObsecure: isObsecurePass,
                        textFieldSuffix: IconButton(
                          icon: isObsecurePass
                              ? Icon(
                                  Icons.visibility_off,
                                  color: ColorHelper.darkgrey,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: ColorHelper.darkgrey,
                                ),
                          onPressed: () {
                            setState(() {
                              isObsecurePass = !isObsecurePass;
                            });
                          },
                        ),
                        textController: passwordController,
                        textHint: "Confirm a Password ",
                        validatorFunction: (value) {
                          CheckEmptyValidationTextField.checkIsEmpty(value);
                          if (value!.length < 8) {
                            return "Password is weak";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isRemembered,
                                onChanged: (value) {
                                  BlocProvider.of<RememberCubit>(context)
                                      .changeRememberMe(
                                    value!,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                },
                                activeColor: ColorHelper.black,
                                checkColor: Colors.white,
                              ),
                              Text(
                                "Remember me",
                                style: TextStyleHelper.textStylefontSize15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyleHelper.textStylefontSize14
                              .copyWith(color: ColorHelper.mintGreen),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomElevatedButton(
                          buttonText: "SignIn",
                          onPressedFunction: () {
                            if (formState.currentState!.validate()) {
                              context.read<LoginCubit>().login(Users(
                                  email: emailController.text,
                                  password: passwordController.text));
                            }
                          },
                          backColor: ColorHelper.mintGreen,
                          fontColor: ColorHelper.white),
                      const SizedBox(
                        height: 20,
                      ),
                      SignUpOrSignInRow(
                        textRow: "Dont have an account ?",
                        textButtonText: "Sign Up",
                        onPressedFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Registration()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
