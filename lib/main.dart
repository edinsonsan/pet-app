import 'package:pet_app/src/config/router/app_router.dart';
import 'package:pet_app/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_providers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      // create: (context) => LoginBloc()..add(LoginInitEvent()),
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme(isDarkmode: false, selectedColor: 6).getTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Pet App',
      ),
    );
  }
}
