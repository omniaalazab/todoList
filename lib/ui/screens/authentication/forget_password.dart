import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/reset_password/reset_password_cubit.dart';
import 'package:todolist/controller/cubit/reset_password/reset_password_state.dart';
import 'package:todolist/controller/functions/check_empty_validation.dart';
import 'package:todolist/helper/color_helper.dart';
import 'package:todolist/helper/text_style_helper.dart';

import 'package:todolist/ui/widget/shared_widget/custom_elevated_button.dart';
import 'package:todolist/ui/widget/shared_widget/dailog_toaster.dart';

import 'package:todolist/ui/widget/shared_widget/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObsecurePass = true;
  bool isObsecureConfirmPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordStatus>(
            listener: (context, state) {
      if (state is ResetPasswordSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else if (state is ResetPasswordFailure) {
        CreateDialogToaster.showErrorToast(state.errorMessage);
      } else if (state is ResetPasswordLoading) {
        CreateDialogToaster.showErrorDialogDefult(
            "loading", "Please wait", context);
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
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
                height: 50,
              ),
              Text("Reset Password",
                  style: TextStyleHelper.textStylefontSize20),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textController: emailController,
                textFieldSuffix: Icon(
                  Icons.mail_outlined,
                  color: ColorHelper.darkgrey,
                ),
                textHint: "Enter your Email address ",
                validatorFunction: (value) {
                  CheckEmptyValidationTextField.checkIsEmpty(value);
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                isObsecure: true,
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
                textHint: "Create a new Password ",
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
                      isObsecurePass = !isObsecurePass;
                    });
                  },
                ),
                isObsecure: true,
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
                  buttonText: "Reset password",
                  onPressedFunction: () {
                    context.read<ResetPasswordCubit>().resetPassword(
                        emailController.text, passwordController.text);
                  },
                  backColor: ColorHelper.mintGreen,
                  fontColor: ColorHelper.white),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      );
    }));
  }
}
