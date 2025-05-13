import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_app/config/config.dart';
import 'package:flutter/material.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    // print(Environment.apiUrl);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: false, selectedColor: 6).getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
    );
  }
}
