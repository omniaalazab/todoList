class ResetPasswordStatus {}

class ResetPasswordInitial extends ResetPasswordStatus {}

class ResetPasswordLoading extends ResetPasswordStatus {}

class ResetPasswordSuccess extends ResetPasswordStatus {
  final String email;
  ResetPasswordSuccess(this.email);
}

class ResetPasswordFailure extends ResetPasswordStatus {
  final String errorMessage;
  ResetPasswordFailure(this.errorMessage);
}
