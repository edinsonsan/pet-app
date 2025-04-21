part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

class NameChanged extends RegisterEvent {
  final Username nombre;
  const NameChanged(this.nombre);
}

class LastnameChanged extends RegisterEvent {
  final Username apellido;
  const LastnameChanged(this.apellido);
}

class EmailChanged extends RegisterEvent {
  final Email email;
  const EmailChanged(this.email);
}

class PhoneChanged extends RegisterEvent {
  final Phone phone;
  const PhoneChanged(this.phone);
}

class PasswordChanged extends RegisterEvent {
  final Password password;
  const PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvent {
  final Confirmpassword confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);
}

class SaveUserSession extends RegisterEvent {
  // final AuthResponse authResponse;
  // SaveUserSession({ required this.authResponse });
}

class FormSubmit extends RegisterEvent {}

class FormReset extends RegisterEvent {}

class ForceValidate extends RegisterEvent {}
