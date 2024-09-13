import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/controller/cubit/reset_password/reset_password_state.dart';
import 'package:todolist/controller/sqllite/sqldb.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStatus> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword(String email, String newPassword) async {
    final Database db = SqlDBHelper.db;
    try {
      emit(ResetPasswordLoading());

      final List<Map<String, dynamic>> result =
          await db.query("SELECT * FROM users WHERE email = '$email'");

      if (result.isEmpty) {
        emit(ResetPasswordFailure("User not found"));
        return;
      }

      await db.update(
        'users',
        {'password': newPassword},
        where: 'email = ?',
        whereArgs: [email],
      );

      emit(ResetPasswordSuccess(email));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
