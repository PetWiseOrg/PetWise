import 'package:flutter/material.dart';
import 'package:petwise/features/authentication/presentation/pages/login/forgot_password_page.dart';
import 'package:petwise/features/authentication/presentation/pages/login/password_reset_page.dart';
import 'package:petwise/features/authentication/presentation/pages/register/additional_info_page.dart';
import 'package:petwise/features/authentication/presentation/pages/register/verify_email_page.dart';
import 'package:petwise/features/home/presentation/pages/home_page.dart';
import 'package:petwise/features/authentication/presentation/pages/login/login_page.dart';
import 'package:petwise/features/authentication/presentation/pages/register/registration_page.dart';
import 'package:petwise/features/authentication/presentation/pages/welcome_page.dart';
import 'package:petwise/features/vet/presentation/pages/vet_dashboard.dart';
import 'package:petwise/features/vet/presentation/pages/vet_clinic_page.dart';
import 'package:petwise/features/vet/presentation/pages/vet_calendar_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  welcomePage,
  loginPage,
  forgotPasswordPage,
  registrationPage,
  homePage,
  forgotPassword,
  passwordReset,
  verifyEmail,
  additionalInfo,
  vetDashboardPage,
  vetClinicPage,
  vetCalendarPage,
  addNewStaffPage,
}

final router = GoRouter(
  initialLocation: '/vet_dashboard',
  routes: [
    // Non-vet routes...
    GoRoute(
      path: '/welcome',
      name: AppRoute.welcomePage.name,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      name: AppRoute.loginPage.name,
      builder: (context, state) => const LoginPage(),
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
      path: '/vet_dashboard',
      name: AppRoute.vetDashboardPage.name,
      builder: (context, state) => const VetDashboardPage(),
      pageBuilder: (context, state) => _noTransitionPage(const VetDashboardPage()),
    ),
    GoRoute(
      path: '/vet_clinic_page',
      name: AppRoute.vetClinicPage.name,
      builder: (context, state) => const VetClinicPage(),
      pageBuilder: (context, state) => _noTransitionPage(const VetClinicPage()),
    ),
    GoRoute(
      path: '/vet_calendar_page',
      name: AppRoute.vetCalendarPage.name,
      builder: (context, state) => const VetCalendarPage(),
      pageBuilder: (context, state) => _noTransitionPage(const VetCalendarPage()),
    ),


  ],
);


//Ensures that there is no animation when navigating to a new page
Page _noTransitionPage(Widget child) {
  return MaterialPage(
    child: child,
  );
}
