import 'package:flutter/material.dart';
import '../theme/app_durations.dart';

/// Transitions de pages élégantes et fluides
class AppPageTransitions {
  /// Transition slide de droite vers gauche (par défaut)
  static Route<T> slideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.pageTransition,
      reverseTransitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  /// Transition fade (apparition en fondu)
  static Route<T> fadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.pageTransition,
      reverseTransitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var tween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }

  /// Transition scale (zoom)
  static Route<T> scaleRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.pageTransition,
      reverseTransitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: 0.8, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        var scaleAnimation = animation.drive(tween);
        var fadeAnimation = animation.drive(
          Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve)),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Transition slide from bottom (pour dialogs, bottom sheets)
  static Route<T> slideFromBottomRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.pageTransition,
      reverseTransitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  /// Transition combinée (slide + fade)
  static Route<T> slideFadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AppDurations.pageTransition,
      reverseTransitionDuration: AppDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.3, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var slideTween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        var slideAnimation = animation.drive(slideTween);
        var fadeAnimation = animation.drive(fadeTween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
    );
  }
}

/// Extensions pour faciliter l'utilisation
extension NavigationExtensions on BuildContext {
  /// Navigation avec transition slide
  Future<T?> pushSlide<T>(Widget page) {
    return Navigator.of(this).push<T>(AppPageTransitions.slideRoute(page));
  }

  /// Navigation avec transition fade
  Future<T?> pushFade<T>(Widget page) {
    return Navigator.of(this).push<T>(AppPageTransitions.fadeRoute(page));
  }

  /// Navigation avec transition scale
  Future<T?> pushScale<T>(Widget page) {
    return Navigator.of(this).push<T>(AppPageTransitions.scaleRoute(page));
  }

  /// Navigation avec transition slide from bottom
  Future<T?> pushSlideFromBottom<T>(Widget page) {
    return Navigator.of(this)
        .push<T>(AppPageTransitions.slideFromBottomRoute(page));
  }

  /// Navigation avec transition slide + fade
  Future<T?> pushSlideFade<T>(Widget page) {
    return Navigator.of(this).push<T>(AppPageTransitions.slideFadeRoute(page));
  }
}
