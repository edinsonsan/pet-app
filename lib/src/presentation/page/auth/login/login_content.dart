import 'package:pet_app/src/presentation/shared/infrastructure/inputs/inputs.dart';
import 'package:pet_app/src/presentation/page/auth/login/bloc/login_bloc.dart';
import 'package:pet_app/src/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginContent extends StatelessWidget {
  final LoginState loginState;
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;
  const LoginContent({
    super.key,
    required this.loginState,
    required this.obscurePassword,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    // final bloc = loginState;
    final loginBloc = context.watch<LoginBloc>();
    final password = loginBloc.state.password;
    final email = loginBloc.state.email;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              // _buildLogo(context),
              _logoPet(),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  // key: loginState.formKey,
                  child: Column(
                    children: [
                      _buildEmailField(
                        isDark,
                        colors,
                        context,
                        loginBloc,
                        email,
                      ),
                      const SizedBox(height: 30.0),
                      _buildPasswordField(isDark, colors, context, password),
                      const SizedBox(height: 30.0),
                      _buildLoginButton(context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildForgotPasswordText(context),
              const SizedBox(height: 40.0),
              _buildLoginWithText(),
              const SizedBox(height: 30.0),
              _buildSocialButtons(),
              const SizedBox(height: 40.0),
              _buildSignUpPrompt(context),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildLogo(BuildContext context) {
  //   final width = MediaQuery.of(context).size.width * 0.80;
  //   final height = MediaQuery.of(context).size.height * 0.35;
  //   return SizedBox(
  //     width: width,
  //     height: height,
  //     child: Image.asset(
  //       "assets/images/logoAutoDark.png",
  //       fit: BoxFit.contain,
  //       width: width,
  //       height: height,
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
            margin: const EdgeInsets.only(top: 50, bottom: 15),
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
                '''
¡Bienvenido! 
  Inicia sesión para continuar
  ''',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(
    bool isDark,
    ColorScheme colors,
    BuildContext context,
    LoginBloc loginBloc,
    Email email,
  ) {
    return CustomTextFormField(
      label: 'Correo',
      hint: 'ejemplo@correo.com',
      prefixIcon: Icon(Icons.email_outlined, color: colors.primary),

      keyboardType: TextInputType.emailAddress,
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
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Ingrese la Contraseña';
      //   }
      //   return null;
      // },
      errorMessage: email.errorMessage,
      onChanged: (value) {
        loginBloc.add(EmailChanged(Email.dirty(value: value)));
      },
    );
  }

  Widget _buildPasswordField(
    bool isDark,
    ColorScheme colors,
    BuildContext context,
    Password password,
  ) {
    return CustomTextFormField(
      label: 'Contraseña',
      obscureText: obscurePassword,
      hint: '************',
      prefixIcon: Icon(Icons.lock_outline, color: colors.primary),
      suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: onToggleVisibility, color: colors.primary,
      ),
      keyboardType: TextInputType.visiblePassword,
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
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Ingrese la contraseña';
      //   }
      //   return null;
      // },
      errorMessage: password.errorMessage,
      onChanged: (value) {
        context.read<LoginBloc>().add(
          PasswordChanged(Password.dirty(value: value)),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
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
          // height: 50,
          child: CustomFilledButton(
            text: 'Ingresar',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            buttonColor: const Color(0xFF273671),
            onPressed: () {
              if (loginState.isValid) {
                context.read<LoginBloc>().add(FormSubmit());
              }
              context.read<LoginBloc>().add(ForceValidate());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/forgot-password');
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
      },
      child: const Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(
          color: Color(0xFF8c8e98),
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLoginWithText() {
    return const Text(
      "o Inicia sesión con",
      style: TextStyle(
        color: Color(0xFF273671),
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // AuthMethods().signInWithGoogle(context);
          },
          child: Image.asset(
            "assets/images/google.png",
            height: 45,
            width: 45,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 30.0),
        GestureDetector(
          onTap: () {
            // AuthMethods().signInWithApple();
          },
          child: Image.asset(
            "assets/images/apple1.png",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿Sin cuenta?",
          style: TextStyle(
            color: Color(0xFF8c8e98),
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5.0),
        GestureDetector(
          onTap: () {
            context.push('/register');
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => SignUp()));
          },
          child: const Text(
            "Regístrate",
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
