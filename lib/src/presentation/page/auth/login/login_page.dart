import 'package:pet_app/src/presentation/page/auth/auth.dart';
import 'package:pet_app/src/presentation/page/auth/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final loginBloc = context.watch<LoginBloc>();
    // LoginBloc bloc = BlocProvider.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return LoginContent(loginState: state, obscurePassword: _obscurePassword,
        onToggleVisibility: _togglePasswordVisibility,);
      },
    );
  }
}
