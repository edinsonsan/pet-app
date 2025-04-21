import 'package:pet_app/src/presentation/page/auth/auth.dart';
import 'package:pet_app/src/presentation/page/auth/forgot_password/bloc/forgot_bloc.dart';
import 'package:pet_app/src/presentation/page/auth/login/bloc/login_bloc.dart';
import 'package:pet_app/src/presentation/page/auth/register/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
  BlocProvider<ForgotBloc>(create: (context) => ForgotBloc(),child: ForgotPassword(),)
];
