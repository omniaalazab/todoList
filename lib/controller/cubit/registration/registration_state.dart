import 'package:todolist/model/user_model.dart';

class RegistrationStatus {}

class RegistrationInitial extends RegistrationStatus {}

class RegistrationLoading extends RegistrationStatus {}

class RegistrationSuccess extends RegistrationStatus {
  final Users user;

  RegistrationSuccess(this.user);
}

class RegistrationFailure extends RegistrationStatus {
  final String error;

  RegistrationFailure(this.error);
}
