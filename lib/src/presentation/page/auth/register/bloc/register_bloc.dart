import 'package:pet_app/src/infrastructure/inputs/inputs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<NameChanged>(_onNameChanged);
    on<LastnameChanged>(_onLastnameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);

    on<FormSubmit>(_onFormSubmit);
    on<FormReset>(_onFormReset);
    on<ForceValidate>(_onForceValidate);
  }

  void _onNameChanged(NameChanged event, Emitter<RegisterState> emit) {
    final nombre = event.nombre;
    emit(
      state.copyWith(
        nombre: nombre,
        isValid: Formz.validate([
          nombre,
          state.apellido,
          state.email,
          state.phone,
          state.password,
          state.confirmPassword,
        ]),
        // formKey: formKey
      ),
    );
  }

  void _onLastnameChanged(LastnameChanged event, Emitter<RegisterState> emit) {
    final apellido = event.apellido;
    emit(
      state.copyWith(
        apellido: apellido,
        isValid: Formz.validate([
          state.nombre,
          apellido,
          state.email,
          state.phone,
          state.password,
          state.confirmPassword,
        ]),
        // formKey: formKey
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final email = event.email;
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.nombre,
          state.apellido,
          email,
          state.phone,
          state.password,
          state.confirmPassword,
        ]),
        // formKey: formKey
      ),
    );
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<RegisterState> emit) {
    final phone = event.phone;
    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate([
          state.nombre,
          state.apellido,
          state.email,
          phone,
          state.password,
          state.confirmPassword,
        ]),
        // formKey: formKey
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final password = event.password;
    final confirmPassword = Confirmpassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.nombre,
          state.apellido,
          state.email,
          state.phone,
          password,
          confirmPassword,
        ]),
        // formKey: formKey,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmPassword = Confirmpassword.dirty(
      password: state.password.value,
      value: event.confirmPassword.value,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.nombre,
          state.apellido,
          state.email,
          state.phone,
          state.password,
          confirmPassword,
        ]),
        // formKey: formKey,
      ),
    );
  }

  void _onFormSubmit(FormSubmit event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        nombre: Username.dirty(value: state.nombre.value),
        apellido: Username.dirty(value: state.apellido.value),
        email: Email.dirty(value: state.email.value),
        phone: Phone.dirty(value: state.phone.value),
        password: Password.dirty(value: state.password.value),
        confirmPassword: Confirmpassword.dirty(
          value: state.confirmPassword.value,
          password: state.password.value,
        ),
        isValid: Formz.validate([
          state.nombre,
          state.apellido,
          state.email,
          state.phone,
          state.password,
          state.confirmPassword,
        ]),
      ),
    );
    print('Name: ${state.nombre}');
    print('LastName: ${state.apellido}');
    print('email: ${state.email}');
    print('phone: ${state.phone}');
    print('password: ${state.password}');
    print('confirmPassword: ${state.confirmPassword}');
  }

  void _onFormReset(FormReset event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
        nombre: const Username.pure(),
        apellido: const Username.pure(),
        email: const Email.pure(),
        phone: const Phone.pure(),
        password: const Password.pure(),
        confirmPassword: const Confirmpassword.pure(''),
        formStatus: FormStatus.invalid,
        isValid: false,
      ),
    );
  }

  void _onForceValidate(ForceValidate event, Emitter<RegisterState> emit) {
    final nombre = Username.dirty(value: state.nombre.value);
    final apellido = Username.dirty(value: state.apellido.value);
    final email = Email.dirty(value: state.email.value);
    final phone = Phone.dirty(value: state.phone.value);
    final password = Password.dirty(value: state.password.value);
    final confirmPassword = Confirmpassword.dirty(
      value: state.confirmPassword.value,
      password: state.password.value,
    );

    emit(
      state.copyWith(
        nombre: nombre,
        apellido: apellido,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          nombre,
          apellido,
          email,
          phone,
          password,
          confirmPassword,
        ]),
      ),
    );
  }
}
