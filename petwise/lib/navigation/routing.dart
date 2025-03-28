import 'package:flutter/material.dart';
import 'package:petwise/ui/ui_authentication/pages/login/forgot_password_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/password_reset_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/additional_info_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/verify_email_page.dart';
import 'package:petwise/ui/ui_home/pages/home_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/login_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/registration_page.dart';
import 'package:petwise/ui/ui_authentication/pages/welcome_page.dart';
import 'package:petwise/ui/ui_authentication/pages/no_connection_page.dart';
import 'package:petwise/ui/ui_calendar/calendar.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { welcomePage, loginPage, forgotPasswordPage, registrationPage, homePage, forgotPassword, passwordReset, verifyEmail, additionalInfo, calendar, noConnection }

final router = GoRouter(
  initialLocation: '/calendar',
  routes: [
    GoRoute(
      path: '/calendar',
      name: AppRoute.calendar.name,
      builder: (context, state) => const Calendar(),
    ),
    GoRoute(
      path: '/welcome',
      name: AppRoute.welcomePage.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        final transition = extra?['transition'];

        return CustomTransitionPage(
          key: state.pageKey,
          child: const WelcomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (transition == 'rightToLeft') {
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              );
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            }
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 200), // Make transition faster
        );
      },
    ),
    GoRoute(
      path: '/login',
      name: AppRoute.loginPage.name,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        final transition = extra?['transition'];

        return CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (transition == 'rightToLeft') {
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              );
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            }
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    GoRoute(
      path: '/forgot_password',
      name: AppRoute.forgotPassword.name,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/password_reset',
      name: AppRoute.passwordReset.name,
      builder: (context, state) => const PasswordResetPage(),
    ),
    GoRoute(
      path: '/registration',
      name: AppRoute.registrationPage.name,
      builder: (context, state) => const RegistrationPage(),
    ),
    GoRoute(
      path: '/verify_email',
      name: AppRoute.verifyEmail.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        final email = extra?['email'];
        final password = extra?['password'];
        return VerifyEmailPage(email: email ?? '', password: password ?? '');
      },
    ),
    GoRoute(
      path: '/additional_info',
      name: AppRoute.additionalInfo.name,
      builder: (context, state) => const AdditionalInfoPage(),
    ),
    GoRoute(
      path: '/',
      name: AppRoute.homePage.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/no_connection',
      name: AppRoute.noConnection.name,
      builder: (context, state) => const NoConnectionPage(),
    ),
  ],
);
