import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:pet_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:pet_app/features/shared/shared.dart';

//! 3 - StateNotifi5erProvider - consume afuera
final forgotFormProvider = StateNotifierProvider.autoDispose<ForgotFormNotifier,ForgotFormState>((ref) {
  final forgotUserCallback = ref.watch(authProvider.notifier).forgotPassword;


  return ForgotFormNotifier(
    forgotUserCallback:forgotUserCallback
  );
});


//! 2 - Como implementamos un notifier
class ForgotFormNotifier extends StateNotifier<ForgotFormState> {

  final Future<void> Function(String) forgotUserCallback;

  ForgotFormNotifier({
    required this.forgotUserCallback,
  }): super( ForgotFormState() );
  
  onEmailChange( String value ) {
    final newEmail = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail ])
    );
  }


  onFormSubmit() async {
    _touchEveryField();

    if ( !state.isValid ) return;
    state = state.copyWith(isPosting: true); // ← Así se actualiza correctamente

    await forgotUserCallback( state.email.value );
    state = state.copyWith(isPosting: false); // ← Así se actualiza correctamente

  }

  _touchEveryField() {

    final email    = Email.dirty(value: state.email.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([ email])
    );

  }

}


//! 1 - State del provider
class ForgotFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;

  ForgotFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
  });

  ForgotFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
  }) => ForgotFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
  );

  @override
  String toString() {
    return '''
  ForgotFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
''';
  }
}