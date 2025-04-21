import 'package:pet_app/src/presentation/shared/infrastructure/inputs/inputs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'forgot_event.dart';
part 'forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  ForgotBloc() : super(const ForgotState()) {
    on<EmailChanged>(_onEmailChanged);
    on<FormSubmit>(_onFormSubmit);
    on<ForceValidate>(_onForceValidate);
  }

  void _onEmailChanged(EmailChanged event, Emitter<ForgotState> emit) {
    final email = event.email;
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
        // formKey: formKey
      ),
    );
  }

  void _onFormSubmit(FormSubmit event, Emitter<ForgotState> emit) {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        email: Email.dirty(value: state.email.value),
        isValid: Formz.validate([state.email]),
      ),
    );
    print('Email: ${state.email}');
  }

  void _onForceValidate(ForceValidate event, Emitter<ForgotState> emit) {
    final email = Email.dirty(value: state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
        ]),
      ),
    );
  }
}
