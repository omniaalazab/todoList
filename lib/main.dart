import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/controller/cubit/login/login_cubit.dart';
import 'package:todolist/controller/cubit/registration/registration_cubit.dart';
import 'package:todolist/controller/cubit/remember/remember_cubit.dart';
import 'package:todolist/controller/cubit/reset_password/reset_password_cubit.dart';
import 'package:todolist/controller/cubit/todo_task/todo_cubit.dart';
import 'package:todolist/controller/sqllite/sqldb.dart';
import 'package:todolist/ui/screens/splash.dart';

void main() async {
  runApp(const ToDoList());
  await SqlDBHelper.initialDB();
}

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegistrationCubit(),
          ),
          BlocProvider(
            create: (context) => ResetPasswordCubit(),
          ),
          BlocProvider(
            create: (context) => RememberCubit(),
          ),
          BlocProvider(
            create: (context) => TaskCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ));
  }
}
