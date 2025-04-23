import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_app/features/auth/presentation/providers/forgot_form_provider.dart';
import 'package:pet_app/features/shared/infrastructure/inputs/inputs.dart';
// import 'package:pet_app/features/auth/presentation/screen/forgot_password/bloc/forgot_bloc.dart';
import 'package:pet_app/features/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  // final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();

  // void _onSendEmail(BuildContext context) {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     final email = _emailController.text.trim();

  //     // Aquí va tu lógica (Bloc event, etc.)
  //     print('Enviar correo a: $email');

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Correo de recuperación enviado")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final ForgotBloc forgotBloc = context.watch<ForgotBloc>();
    final forgotProvider = ref.watch(forgotFormProvider);
    final email = forgotProvider.email;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  _buildTitle(),
                  const SizedBox(height: 12.0),
                  _buildSubtitle(),
                  const SizedBox(height: 30),

                  _buildEmailForm(context, email, ref),

                  const SizedBox(height: 40),
                  CustomFilledButton(
                    text: "Enviar correo",

                    onPressed: () {
                      ref.read(forgotFormProvider.notifier).onFormSubmit();
                    },
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    prefixIcon: const Icon(Icons.send, color: Colors.black),
                  ),

                  const SizedBox(height: 40),
                  _buildSignUpPrompt(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        "Recuperar Contraseña",
        style: TextStyle(
          color: Colors.white,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Center(
      child: Text(
        "Ingrese su correo electrónico",
        style: TextStyle(color: Colors.white70, fontSize: 18.0),
      ),
    );
  }

  Widget _buildEmailForm(BuildContext context, Email email, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return Form(
      // key: _formkey,
      child: CustomTextFormField(
        // controller: _emailController,
        hint: "Correo electrónico",
        label: "Correo",
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icon(Icons.email, color: colors.primary),
        // ignore: deprecated_member_use
        backgroundColor: colors.surface.withOpacity(0.1),
        textColor: colors.secondary,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Por favor, introduce tu correo';
        //   }
        //   if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value)) {
        //     return 'Introduce un correo válido';
        //   }
        //   return null;
        // },
        onChanged: ref.read(forgotFormProvider.notifier).onEmailChange,
        errorMessage: email.errorMessage,
      ),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿No tienes cuenta?",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            context.pop();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => SignUp()));
          },
          child: const Text(
            "Crear cuenta",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 215, 0),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
