import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/config/router/app_router_notifier.dart';
import 'package:pet_app/features/auth/auth.dart';
import 'package:pet_app/features/products/products.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
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

      ///* Product Routes
      GoRoute(path: '/', builder: (context, state) => const ProductsScreen()),
    ],
    
    redirect: (context, state) {
      
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/forgot-password' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
          return '/';
        }
      }


      return null;
    },

    
  );
});

// GoRouter configuration
// final appRouter = 
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
//   ],
// );
