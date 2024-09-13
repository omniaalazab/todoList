import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/registration/registration_cubit.dart';
import 'package:todolist/controller/cubit/registration/registration_state.dart';
import 'package:todolist/controller/functions/check_empty_validation.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';
import 'package:todolist/model/user_model.dart';
import 'package:todolist/ui/screens/authentication/login.dart';
import 'package:todolist/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:todolist/ui/widget/shared_widget/dailog_toaster.dart';
import 'package:todolist/ui/widget/signin_signout_row.dart';
import 'package:todolist/ui/widget/shared_widget/text_field.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _LoginState();
}

class _LoginState extends State<Registration> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  bool isObsecurePass = true;
  bool isObsecureConfirmPass = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  void initState() {
    isObsecurePass = true;
    isObsecureConfirmPass = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegistrationCubit, RegistrationStatus>(
          listener: (context, state) {
        if (state is RegistrationSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        } else if (state is RegistrationLoading) {
          CreateDialogToaster.showErrorDialogDefult(
              "loading", "Please wait", context);
        } else if (state is RegistrationFailure) {
          if (state.error == 'weak-password') {
            CreateDialogToaster.showErrorToast("password is weak");
          } else if (state.error == 'email-already-in-use') {
            CreateDialogToaster.showErrorToast(" please use another mail");
          } else {
            CreateDialogToaster.showErrorToast(state.error);
          }
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
            child: Form(
              key: formState,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Welcome Onboard!",
                      style: TextStyleHelper.textStylefontSize20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      "Let’s help you meet up your task",
                      style: TextStyleHelper.textStylefontSize20
                          .copyWith(color: ColorHelper.mintGreen),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textController: fullNameController,
                    textFieldSuffix: Icon(
                      Icons.person_outline_rounded,
                      color: ColorHelper.darkgrey,
                    ),
                    textHint: "Enter your Full Name",
                    validatorFunction: (value) {
                      CheckEmptyValidationTextField.checkIsEmpty(value);
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textController: emailController,
                    textFieldSuffix: Icon(
                      Icons.mail_outlined,
                      color: ColorHelper.darkgrey,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textHint: "Enter your Email address ",
                    validatorFunction: (value) {
                      CheckEmptyValidationTextField.checkIsEmpty(value);
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                    textHint: "Create a Password ",
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
                  CustomTextField(
                    textFieldSuffix: IconButton(
                      icon: isObsecureConfirmPass
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
                          isObsecureConfirmPass = !isObsecureConfirmPass;
                        });
                      },
                    ),
                    isObsecure: isObsecureConfirmPass,
                    textController: confirmPasswordController,
                    textHint: "Confirm your Password",
                    validatorFunction: (value) {
                      CheckEmptyValidationTextField.checkIsEmpty(value);
                      if (passwordController.text != value) {
                        return "Confirm doesn't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomElevatedButton(
                      buttonText: "SignUp",
                      onPressedFunction: () {
                        if (formState.currentState!.validate()) {
                          context.read<RegistrationCubit>().registration(Users(
                                fullName: fullNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        }
                      },
                      backColor: ColorHelper.mintGreen,
                      fontColor: ColorHelper.white),
                  const SizedBox(
                    height: 50,
                  ),
                  SignUpOrSignInRow(
                    textRow: "Already have an account ? ",
                    textButtonText: "Sign In",
                    onPressedFunction: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Login()));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
