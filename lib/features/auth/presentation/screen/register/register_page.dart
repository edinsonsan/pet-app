// import 'package:pet_app/src/presentation/page/auth/auth.dart';
// import 'package:pet_app/features/auth/presentation/screen/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/features/auth/presentation/screen/register/register_content.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
    _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RegisterContent(
          obscurePassword: _obscurePassword,
          onToggleVisibility: _togglePasswordVisibility,
        );
  }
}
