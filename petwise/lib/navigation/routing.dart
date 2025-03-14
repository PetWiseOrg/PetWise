import 'package:petwise/data/models/pet.dart';
import 'package:petwise/ui/ui_authentication/pages/login/forgot_password_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/password_reset_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/additional_info_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/verify_email_page.dart';
import 'package:petwise/ui/ui_home/pages/home_page.dart';
import 'package:petwise/ui/ui_authentication/pages/login/login_page.dart';
import 'package:petwise/ui/ui_authentication/pages/register/registration_page.dart';
import 'package:petwise/ui/ui_authentication/pages/welcome_page.dart';
import 'package:go_router/go_router.dart';
import 'package:petwise/ui/pet_owner/dashboard/presentation/pages/pet_owner_dashboard_page.dart';
import 'package:petwise/ui/pet_owner/pet/presentation/pages/edit_owner_page.dart';
import 'package:petwise/ui/pet_owner/pet/presentation/pages/edit_pet_page.dart';
import 'package:petwise/ui/pet_owner/profile/presentation/pages/pet_owner_profile_page.dart';

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
  petOwnerDashboardPage,
  petOwnerProfilePage,
  editPetPage,
  editOwnerPage,
}

final router = GoRouter(
  initialLocation: '/petOwnerDashboardPage',
  routes: [
    GoRoute(
      path: '/welcome',
      name: AppRoute.welcomePage.name,
      builder: (context, state) => WelcomePage(),
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
  ],
);
