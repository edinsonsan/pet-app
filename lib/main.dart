import 'package:pet_app/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_providers.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Environment.apiUrl);
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
