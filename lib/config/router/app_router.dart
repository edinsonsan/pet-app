
import 'package:go_router/go_router.dart';
import 'package:pet_app/features/auth/auth.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      // name: HomeScreen.name,
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: '/register',
      // name: CounterScreeen.name,
      builder: (context, state) => const RegisterPage(),
    ),

    GoRoute(
      path: '/forgot-password',
      // name: ButtonsScreen.name,
      builder: (context, state) => const ForgotPassword(),
    ),

    // GoRoute(
    //   path: '/cards',
    //   name: CardsScreen.name,
    //   builder: (context, state) =>  const CardsScreen(),
    // ),

    // GoRoute(
    //   path: '/progress',
    //   name: ProgressScreen.name,
    //   builder: (context, state) =>  const ProgressScreen(),
    // ),

    // GoRoute(
    //   path: '/snackbar',
    //   name: SnackbarScreen.name,
    //   builder: (context, state) =>  const SnackbarScreen(),
    // ),

    // GoRoute(
    //   path: '/animated',
    //   name: AnimatedScreen.name,
    //   builder: (context, state) =>  const AnimatedScreen(),
    // ),

    // GoRoute(
    //   path: '/ui-controls',
    //   name: UiControllsScreen.name,
    //   builder: (context, state) =>  const UiControllsScreen(),
    // ),

    // GoRoute(
    //   path: '/tutorial',
    //   name: AppTutorialScreen.name,
    //   builder: (context, state) =>  const AppTutorialScreen(),
    // ),

    // GoRoute(
    //   path: '/infinite',
    //   name: InfiniteScrollScreen.name,
    //   builder: (context, state) =>  const InfiniteScrollScreen(),
    // ),

    // GoRoute(
    //   path: '/theme-changer',
    //   name: ThemeChangerScreen.name,
    //   builder: (context, state) =>  const ThemeChangerScreen(),
    // ),

  ],
);