/*
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum TransitionType {
  fadeIn,
  fadeOut,
  slideUp,
  slideDown,
  scale,
  smartAnimate,
  moveIn,
}

enum AnimationCurve {
  slow,
  gentle,
  easeInOut,
  easeIn,
  easeOut,
  linear,
}

class PageTransitionHelper {
  /// Converts the enum representation of curves to the actual Flutter curve
  static Curve getCurve(AnimationCurve curve) {
    switch (curve) {
      case AnimationCurve.slow:
        return Curves.easeOutCirc; // Smoother than easeOutSine
      case AnimationCurve.gentle:
        return Curves.easeInOutQuad;
      case AnimationCurve.easeInOut:
        return Curves.easeInOutCubic; // More smooth cubic curve
      case AnimationCurve.easeIn:
        return Curves.easeInCubic; // More smooth cubic curve
      case AnimationCurve.easeOut:
        return Curves.easeOutCubic; // More smooth cubic curve
      case AnimationCurve.linear:
        return Curves.linear;
    }
  }

  /// Creates a page route with specified transition
  static Route createRoute({
    required Widget page,
    required TransitionType transitionType,
    required AnimationCurve curve,
    required Duration duration,
    Offset? beginOffset,
    Offset? endOffset,
    required bool opaque,
  }) {
    return PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Use a higher priority schedule to ensure smoother animations
        SchedulerBinding.instance.addPostFrameCallback((_) {
          SchedulerBinding.instance.scheduleFrame();
        });
        
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: getCurve(curve),
        );

        switch (transitionType) {
          case TransitionType.fadeIn:
            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          case TransitionType.fadeOut:
            return FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
              child: child,
            );
          case TransitionType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case TransitionType.slideDown:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          case TransitionType.scale:
            return ScaleTransition(
              scale: curvedAnimation,
              child: child,
            );
          case TransitionType.smartAnimate:
            // Smart animate in Flutter - mimics Figma's Smart Animate with a combination of fade and scale
            return FadeTransition(
              opacity: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.97, end: 1.0).animate(curvedAnimation),
                child: child,
              ),
            );
          case TransitionType.moveIn:
            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset ?? const Offset(0.0, 1.0),
                end: endOffset ?? Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
        }
      },
    );
  }

  /// Helper method for smart animate transitions with slow curve
  static Route createSlowSmartAnimate({
    required Widget page,
    required String routeName,
    required Duration duration,
  }) {
    return createRoute(
      page: page,
      transitionType: TransitionType.smartAnimate,
      curve: AnimationCurve.slow,
      duration: duration,
      opaque: true,
      beginOffset: null,
      endOffset: null,
    );
  }

  /// Helper method for smart animate transitions with gentle curve
  static Route createGentleSmartAnimate({
    required Widget page,
    required String routeName,
    required Duration duration,
  }) {
    return createRoute(
      page: page,
      transitionType: TransitionType.smartAnimate,
      curve: AnimationCurve.gentle,
      duration: duration,
      opaque: true,
      beginOffset: null,
      endOffset: null,
    );
  }

  /// Helper method for move in from top transitions
  static Route createMoveInFromTop({
    required Widget page,
    required String routeName,
    required Duration duration,
  }) {
    return createRoute(
      page: page,
      transitionType: TransitionType.moveIn,
      curve: AnimationCurve.easeIn,
      duration: duration,
      beginOffset: const Offset(0.0, -1.0),
      endOffset: Offset.zero,
      opaque: true,
    );
  }
}
*/