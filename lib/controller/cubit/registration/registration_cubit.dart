import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/controller/cubit/registration/registration_state.dart';
import 'package:todolist/controller/sqllite/sqldb.dart';
import 'package:todolist/model/user_model.dart';

class RegistrationCubit extends Cubit<RegistrationStatus> {
  RegistrationCubit() : super(RegistrationInitial());

  Future<void> registration(Users user) async {
    final Database db = SqlDBHelper.db;
    try {
      emit(RegistrationLoading());
      await db.insert('users', user.tojson());
      log("Sucess");
      emit(RegistrationSuccess(user));
    } catch (e) {
      log(e.toString());
      emit(RegistrationFailure(e.toString()));
    }
  }
}
