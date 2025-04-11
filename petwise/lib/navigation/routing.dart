import 'package:flutter/material.dart';
import 'package:petwise/data/models/pet.dart';
import 'package:petwise/ui/ui_authentication/pages/login/forgot_password_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/password_reset_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/additional_info_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/verify_email_page.dart';
import 'package:petwise/ui/ui_home/pages/home_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/login_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/registration_page.dart';
import 'package:petwise/ui/ui_authentication/pages/welcome_page.dart';
import 'package:petwise/ui/ui_authentication/pages/no_connection_page.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/ui/ui_pet_owner/pages/appointment_summary_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/clinic_details_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/find_clinic_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/messaging_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/pet_owner_dashboard_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/edit_owner_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/edit_pet_page.dart';
import 'package:petwise/ui/ui_pet_owner/pages/pet_owner_profile_page.dart';

enum AppRoute { welcomePage, loginPage, forgotPasswordPage, registrationPage, homePage, forgotPassword, passwordReset, verifyEmail, additionalInfo,
  petOwnerDashboardPage,
  petOwnerProfilePage,
  editPetPage,
  messagingPage, findClinicPage, clinicDetailsPage, appointmentSummaryPage,
  editOwnerPage, noConnection }

final router = GoRouter(
  initialLocation: '/messagingPage',
  routes: [
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
    GoRoute(
      path: '/petOwnerDashboardPage',
      name: AppRoute.petOwnerDashboardPage.name,
      builder: (context, state) => const PetOwnerDashboardPage(),
    ),
    GoRoute(
      path: '/petOwnerProfilePage',
      name: AppRoute.petOwnerProfilePage.name,
      builder: (context, state) => const PetOwnerProfilePage(),
    ),
    GoRoute(
      path: '/editPetPage',
      name: AppRoute.editPetPage.name,
      builder: (context, state) {
        final pet = state.extra as Pet;
        return EditPetPage(pet: pet,);
      },
    ),
    GoRoute(
      path: '/editOwnerPage',
      name: AppRoute.editOwnerPage.name,
      builder: (context, state) => EditOwnerPage(),
    ),
    GoRoute(
      path: '/messagingPage',
      name: AppRoute.messagingPage.name,
      builder: (context, state) => MessagingPage(),
    ),
    GoRoute(
      path: '/findClinicPage',
      name: AppRoute.findClinicPage.name,
      builder: (context, state) => FindClinicPage(),
    ),
    GoRoute(
      path: '/clinicDetailsPage',
      name: AppRoute.clinicDetailsPage.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return ClinicDetailsPage(
          clinicName: extra['clinicName'] ?? '',
          rating: extra['rating'] ?? 0.0,
          description: extra['description'] ?? '',
          address: extra['address'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/appointmentSummaryPage',
      name: AppRoute.appointmentSummaryPage.name,      
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return AppointmentSummaryPage(
          clinicName: extra['clinicName'] ?? '',
          rating: extra['rating'] ?? 0.0,
          concernsSummary: extra['concernsSummary'] ?? '',
          appointmentDateTime: extra['appointmentDateTime'] ?? DateTime.now(),
          address: extra['address'] ?? '',
        );
      },
    ),
  ],
);
