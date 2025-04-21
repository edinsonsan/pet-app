part of 'forgot_bloc.dart';

sealed class ForgotEvent {
  const ForgotEvent();
}


class EmailChanged extends ForgotEvent {
  final Email email;
  const EmailChanged(this.email);
}

class FormSubmit extends ForgotEvent {}

class ForceValidate extends ForgotEvent {}
