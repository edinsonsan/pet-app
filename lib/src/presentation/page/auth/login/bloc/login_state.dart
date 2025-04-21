part of 'login_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final GlobalKey<FormState>? formKey;
  final bool isValid;
  final FormStatus formStatus;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formKey,
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    GlobalKey<FormState>? formKey,
    bool? isValid,
    FormStatus? formStatus,
  }) => LoginState(
    email: email ?? this.email,
    password: password ?? this.password,
    formKey: formKey,
    isValid: isValid ?? this.isValid,
    formStatus: formStatus ?? this.formStatus,
  );

  @override
  List<Object> get props => [email, password, isValid, formStatus];
}
