import 'package:todolist/model/user_model.dart';

class LoginStatus {}

class LoginInitial extends LoginStatus {}

class LoginLoading extends LoginStatus {}

class LoginSuccess extends LoginStatus {
  final Users user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginStatus {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}
