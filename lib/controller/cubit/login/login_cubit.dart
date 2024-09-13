import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/controller/cubit/login/login_state.dart';
import 'package:todolist/controller/sqllite/sqldb.dart';
import 'package:todolist/model/user_model.dart';

class LoginCubit extends Cubit<LoginStatus> {
  LoginCubit() : super(LoginInitial());

  Future<bool> login(Users user) async {
    final Database db = SqlDBHelper.db;
    try {
      emit(LoginLoading());
      List<Map> response = await db.rawQuery(
          "SELECT * FROM 'users' WHERE email='${user.email}' AND password='${user.password}'");
      if (response.isNotEmpty) {
        log("loginSucess");
        emit(LoginSuccess(user));
        return true;
      } else {
        log("***///******");
        return false;
      }
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(e.toString()));
      return false;
    }
  }
}
