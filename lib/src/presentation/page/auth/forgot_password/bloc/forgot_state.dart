part of 'forgot_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class ForgotState extends Equatable {
  final Email email;
  final bool isValid;
  final FormStatus formStatus;

  const ForgotState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
  });

  ForgotState copyWith({
    Email? email,
    bool? isValid,
    FormStatus? formStatus,
  }) => ForgotState(
    email: email ?? this.email,
    isValid: isValid ?? this.isValid,
    formStatus: formStatus ?? this.formStatus,
  );

  @override
  List<Object> get props => [email, isValid, formStatus];
}
