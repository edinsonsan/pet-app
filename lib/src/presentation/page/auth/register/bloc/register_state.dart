part of 'register_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterState extends Equatable {
  final Username nombre;
  final Username apellido;
  final Email email;
  final Phone phone;
  final Password password;
  final Confirmpassword confirmPassword;
  final bool isValid;
  final FormStatus formStatus;

  const RegisterState({
    this.nombre = const Username.pure(),
    this.apellido = const Username.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    Confirmpassword? confirmPassword,
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
  }) : confirmPassword = confirmPassword ?? const Confirmpassword.pure('');

  RegisterState copyWith({
    Username? nombre,
    Username? apellido,
    Email? email,
    Phone? phone,
    Password? password,
    Confirmpassword? confirmPassword,
    // GlobalKey<FormState>? formKey,
    bool? isValid,
    FormStatus? formStatus,
  }) {
    final updatePassword = password ?? this.password;

    return RegisterState(
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: updatePassword,
      confirmPassword:
          confirmPassword ??
          Confirmpassword.dirty(
            password: updatePassword.value,
            value: this.confirmPassword.value,
          ),
      // formKey: formKey,
      isValid: isValid ?? this.isValid,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [
    nombre,
    apellido,
    email,
    phone,
    password,
    confirmPassword,
    isValid,
    formStatus,
  ];
}
