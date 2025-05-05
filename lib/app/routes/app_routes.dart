/*
import 'package:flutter/material.dart';
import '../../presentation/pages/splash/splash1.dart';
import '../../presentation/pages/splash/splash2.dart';
import '../../presentation/pages/splash/splash3.dart';
import '../../presentation/pages/splash/splash4.dart';
import '../../presentation/pages/splash/splash5.dart';
import '../../core/utils/page_transition_helper.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String splash1 = '/splash1';
  static const String splash2 = '/splash2';
  static const String splash3 = '/splash3';
  static const String splash4 = '/splash4';
  static const String splash5 = '/splash5';
  static const String login = '/login';
  static const String home = '/home';

  // onGenerateRoute untuk menerapkan animasi transisi
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
      case splash1:
        return MaterialPageRoute(builder: (_) => const Splash1());
      
      case splash2:
        return PageTransitionHelper.createRoute(
          page: const Splash2(),
          transitionType: TransitionType.smartAnimate,
          curve: AnimationCurve.slow,
          duration: const Duration(milliseconds: 600),
          opaque: true,
          beginOffset: null,
          endOffset: null,
        );

      case splash3:
        return PageTransitionHelper.createRoute(
          page: const Splash3(),
          transitionType: TransitionType.smartAnimate,
          curve: AnimationCurve.gentle,
          duration: const Duration(milliseconds: 8000),
          opaque: true,
          beginOffset: null,
          endOffset: null,
        );

      case splash4:
        return PageTransitionHelper.createRoute(
          page: const Splash4(),
          transitionType: TransitionType.smartAnimate,
          curve: AnimationCurve.slow,
          duration: const Duration(milliseconds: 1200),
          opaque: true,
          beginOffset: null,
          endOffset: null,
        );

      case splash5:
        return PageTransitionHelper.createRoute(
          page: const Splash5(),
          transitionType: TransitionType.smartAnimate,
          curve: AnimationCurve.easeInOut,
          duration: const Duration(milliseconds: 300),
          opaque: true,
          beginOffset: null,
          endOffset: null,
        );

      case login:
        return PageTransitionHelper.createRoute(
          page: const Scaffold(
            body: Center(
              child: Text('Login Page - Coming Soon'),
            ),
          ),
          transitionType: TransitionType.moveIn,
          curve: AnimationCurve.easeIn,
          duration: const Duration(milliseconds: 1200),
          beginOffset: const Offset(0.0, -1.0),
          endOffset: Offset.zero,
          opaque: true,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // Routes map untuk backward compatibility
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const Splash1(),
      splash1: (context) => const Splash1(),
      splash2: (context) => const Splash2(),
      splash3: (context) => const Splash3(),
      splash4: (context) => const Splash4(),
      splash5: (context) => const Splash5(),
      login: (context) => const Scaffold(
        body: Center(
          child: Text('Login Page - Coming Soon'),
        ),
      ),
      // home: (context) => const HomePage(),  // Uncomment nanti setelah dibuat
    };
  }
}
*/