import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:pet_app/features/shared/shared.dart';
import 'package:pet_app/features/auth/presentation/providers/auth_provider.dart';

//! 3 - StateNotifierProvider - consume afuera
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((
      ref,
    ) {
      final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

      return RegisterFormNotifier(registerUserCallback: registerUserCallback);
    });

//! 2 - Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Future<void> Function(String, String, String, String) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
    : super(RegisterFormState());

  onNameChange(String value) {
    final newName = Username.dirty(value: value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName,
        state.email,
        state.phone,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        state.name,
        newEmail,
        state.phone,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onPhoneChange(String value) {
    final newPhone = Phone.dirty(value: value);
    state = state.copyWith(
      phone: newPhone,
      isValid: Formz.validate([
        state.name,
        state.email,
        newPhone,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value: value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        state.name,
        state.email,
        state.phone,
        newPassword,
        state.confirmPassword,
      ]),
    );
  }

  onConfirmPasswordChanged(String value) {
    final newConfirmPassword = Confirmpassword.dirty(
      password: state.password.value,
      value: value,
    );
    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate([
        state.name,
        state.email,
        state.phone,
        state.password,
        newConfirmPassword,
      ]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await registerUserCallback(state.name.value ,state.email.value, state.password.value, state.confirmPassword.value);
  }

  _touchEveryField() {
    final name = Username.dirty(value: state.name.value);
    final email = Email.dirty(value: state.email.value);
    final phone = Phone.dirty(value: state.phone.value);
    final password = Password.dirty(value: state.password.value);
    final confirmPassword = Confirmpassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    state = state.copyWith(
      isFormPosted: true,
      name: name,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([
        name,
        email,
        phone,
        password,
        confirmPassword,
      ]),
    );
  }
}

//! 1 - State del provider
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username name;
  final Email email;
  final Phone phone;
  final Password password;
  final Confirmpassword confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Username.pure(),
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    Confirmpassword? confirmPassword,
  }) : confirmPassword = confirmPassword ?? const Confirmpassword.pure('');

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? name,
    // Username? apellido,
    Email? email,
    Phone? phone,
    Password? password,
    Confirmpassword? confirmPassword,
  }) {
    final updatePassword = password ?? this.password;

    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: updatePassword,
      confirmPassword:
          confirmPassword ??
          Confirmpassword.dirty(
            password: updatePassword.value,
            value: this.confirmPassword.value,
          ),
    );
  }

  @override
  String toString() {
    return '''
  RegisterFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    name: $name
    email: $email
    password: $password
''';
  }
}
