import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_app/features/auth/presentation/presentation.dart';
import 'package:pet_app/features/shared/infrastructure/inputs/inputs.dart';
// import 'package:pet_app/features/auth/presentation/screen/register/bloc/register_bloc.dart';
import 'package:pet_app/features/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterContent extends ConsumerWidget {
  // final RegisterState state;
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;
  const RegisterContent({
    super.key,
    // required this.state,
    required this.obscurePassword,
    required this.onToggleVisibility,
  });

  void snackBar(BuildContext context, AuthState next) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(next.errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerProvider = ref.watch(registerFormProvider);
    final name = registerProvider.name;
    final email = registerProvider.email;
    final phone = registerProvider.phone;
    final password = registerProvider.password;
    final confirmPassword = registerProvider.confirmPassword;

    final colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authProvider, (previous, next) {
      snackBar(context, next);
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // _buildLogo(context),
              _logoPet(),
              _buildForm(
                context,
                isDark,
                colors,
                name,
                email,
                phone,
                password,
                confirmPassword,
                ref,
                registerProvider,
              ),
              const SizedBox(height: 40.0),
              _buildSocialLoginSection(),
              const SizedBox(height: 40.0),
              _buildFooter(context),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  // Logo Section
  // Widget _buildLogo(BuildContext context) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.80,
  //     height: MediaQuery.of(context).size.height * 0.35,
  //     child: Image.asset(
  //       "assets/images/logoAutoDark.png",
  //       fit: BoxFit.contain,
  //       width: MediaQuery.of(context).size.width * 0.80,
  //       height: MediaQuery.of(context).size.height * 0.35,
  //     ),
  //   );
  // }

  Widget _logoPet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo container
          Container(
            margin: const EdgeInsets.only(top: 60, bottom: 15),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFF8C42), Color(0xFFF9A826)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF9A826).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '🐾',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
          ),

          // App name
          const Text(
            "PetApp",
            style: TextStyle(
              // color: Colors.black,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Welcome text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                'Crea una cuenta para comenzar tu experiencia',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // Form Section
  Widget _buildForm(
    BuildContext context,
    bool isDark,
    ColorScheme colors,
    Username nombre,
    Email email,
    Phone phone,
    Password password,
    Confirmpassword confirmPassword,
    WidgetRef ref,
    RegisterFormState registerProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: Column(
          children: [
            _buildTextField(
              label: 'Nombre',
              hint: 'Nombre Mascota',
              prefixIcon: Icons.supervised_user_circle_outlined,
              keyboardType: TextInputType.text,
              isDark: isDark,
              colors: colors,
              // validator:
              //     (value) =>
              //         value == null || value.isEmpty
              //             ? 'Ingrese el Nombre'
              //             : null,
              onChanged: ref.read(registerFormProvider.notifier).onNameChange,
              errorMessage:
                  registerProvider.isFormPosted ? nombre.errorMessage : null,
            ),

            const SizedBox(height: 20),

            _buildTextField(
              label: 'Correo',
              hint: 'ejemplo@correo.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              isDark: isDark,
              colors: colors,
              // validator:
              //     (value) =>
              //         value == null || value.isEmpty
              //             ? 'Ingrese el Correo'
              //             : null,
              onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
              errorMessage:
                  registerProvider.isPosting ? email.errorMessage : null,
            ),

            const SizedBox(height: 20),
            _buildTextField(
              label: 'Número de celular',
              hint: '987654321',
              prefixIcon: Icons.phone_in_talk_outlined,
              keyboardType: TextInputType.phone,
              isDark: isDark,
              colors: colors,
              // validator:
              //     (value) =>
              //         value == null || value.isEmpty
              //             ? 'Ingrese el Número de celular'
              //             : null,
              onChanged: ref.read(registerFormProvider.notifier).onPhoneChange,
              errorMessage:
                  registerProvider.isPosting ? phone.errorMessage : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Contraseña',
              hint: '*************',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: colors.primary,
                ),
                onPressed: onToggleVisibility,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscurePassword,
              isDark: isDark,
              colors: colors,
              // validator:
              //     (value) =>
              //         value == null || value.isEmpty
              //             ? 'Ingrese la Contraseña'
              //             : null,
              onChanged:
                  ref.read(registerFormProvider.notifier).onPasswordChanged,
              errorMessage:
                  registerProvider.isFormPosted ? password.errorMessage : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Confirmar Contraseña',
              hint: 'Ingresar Contraseña',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: colors.primary,
                ),
                onPressed: onToggleVisibility,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscurePassword,
              isDark: isDark,
              colors: colors,
              // validator:
              //     (value) =>
              //         value == null || value.isEmpty ? '*************' : null,
              // onChanged: (value) {},
              onChanged: (value) {
                ref
                    .read(registerFormProvider.notifier)
                    .onConfirmPasswordChanged(value);
                // context.read<RegisterBloc>().add(
                //   ConfirmPasswordChanged(
                //     Confirmpassword.dirty(
                //       value: value,
                //       password: state.password.value,
                //     ),
                //   ),
                // );
              },
              errorMessage:
                  registerProvider.isPosting
                      ? confirmPassword.errorMessage
                      : null,
            ),
            const SizedBox(height: 30.0),
            _buildRegisterButton(
              onPressed: () {
                ref.read(registerFormProvider.notifier).onFormSubmit();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Custom Text Field
  // (BuildContext context)
  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
    required TextInputType keyboardType,
    bool obscureText = false,
    required bool isDark,
    required ColorScheme colors,
    required dynamic Function(String)? onChanged,
    required String? errorMessage,
  }) {
    return CustomTextFormField(
      label: label,
      hint: hint,
      prefixIcon: Icon(prefixIcon, color: colors.primary),
      suffixIcon: suffixIcon,
      keyboardType: keyboardType,
      obscureText: obscureText,
      backgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFedf0f8),
      textColor: isDark ? Colors.grey[300] : Colors.black87,
      hintStyle: TextStyle(
        color: isDark ? Colors.grey[400] : const Color(0xFFb2b7bf),
        fontSize: 18.0,
      ),
      floatingLabelStyle: TextStyle(
        color: colors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      // validator: validator,
      errorMessage: errorMessage,
      onChanged: onChanged,
    );
  }

  // Register Button
  Widget _buildRegisterButton({void Function()? onPressed}) {
    return GestureDetector(
      onTap: () {
        // if(_formkey.currentState!.validate()){
        //   setState(() {
        //     email= mailcontroller.text;
        //     password=passwordcontroller.text;
        //   });
        // }
        // userLogin();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: CustomFilledButton(
            text: 'Registrate',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            buttonColor: const Color(0xFF273671),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  // Social Login Section
  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        const Text(
          "o Inicia sesión con",
          style: TextStyle(
            color: Color(0xFF273671),
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 30.0),
            Image.asset(
              "assets/images/apple1.png",
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ],
    );
  }

  // Footer Section
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿Tienes una cuenta?",
          style: TextStyle(
            color: Color(0xFF8c8e98),
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5.0),
        GestureDetector(
          onTap: () {
            context.pop();
            // Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
          },
          child: const Text(
            "Ingresar",
            style: TextStyle(
              color: Color(0xFF273671),
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
