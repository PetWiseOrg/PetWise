import 'package:petwise/core/common_widgets/test_widgets/go_named_back_button_testing.dart';
import 'package:petwise/core/common_widgets/themed_text_field.dart';
import 'package:petwise/core/localization/string_extensions.dart';
import 'package:petwise/core/navigation/routing.dart';
import 'package:petwise/core/theme/app_theme.dart';
import 'package:petwise/features/authentication/presentation/widgets/login_register_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:petwise/features/authentication/domain/auth_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final errorNotifier = ValueNotifier<String?>(null);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    errorNotifier.dispose();
    super.dispose();
  }

  void register(
      BuildContext context,
      ValueNotifier<String?> errorNotifier,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!'.hardcoded)),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.createUser(
          {'email': email, 'password': password, 'passwordConfirm': password});
      if (context.mounted) {
        context.goNamed(
          AppRoute.verifyEmail.name,
          extra: {'email': email, 'password': password},
        );
      }
    } catch (error) {
      if (!mounted) return;
      final errorString = error.toString();
      final start = errorString.indexOf('message:');
      final end = errorString.indexOf(",", start);
      final message = errorString.substring(start + 9, end);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void loginRedirect(BuildContext context) {
    context.goNamed(AppRoute.loginPage.name);
  }

  Widget wrap(Widget widget, double height) {
    return SizedBox(
      height: height,
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    const double heightPerObject = 75;

    final loginText = Text.rich(TextSpan(
        text: 'Already have an account? '.hardcoded,
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: 'Login now'.hardcoded,
            style: clickableStyleMedium,
          )
        ]));

    return Scaffold(
      appBar: GoNamedBackButtonTesting(name: AppRoute.welcomePage.name),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo.jpg',
                  width: 150,
                  height: 150,
                ),
                const Text(
                  'PetWise',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    wrap(
                        ThemedTextField(
                          hintText: 'Email'.hardcoded,
                          controller: emailController,
                        ),
                        heightPerObject),
                    wrap(
                        ThemedTextField(
                          hintText: 'Password'.hardcoded,
                          controller: passwordController,
                          obscureText: true,
                        ),
                        heightPerObject),
                    wrap(
                        ThemedTextField(
                          hintText: 'Confirm Password'.hardcoded,
                          controller: confirmPasswordController,
                          obscureText: true,
                        ),
                        heightPerObject),
                    wrap(
                        LoginRegisterButton(
                          onTap: () => register(
                              context,
                              errorNotifier,
                              emailController,
                              passwordController,
                              confirmPasswordController),
                          message: 'Register'.hardcoded,
                          textStyle: titleStyleMedium,
                          padding: 4,
                          elevation: 4,
                        ),
                        heightPerObject),
                  ],
                ),
                const SizedBox(height: 10),
                wrap(
                    GestureDetector(
                      onTap: () => loginRedirect(context),
                      child: loginText,
                    ),
                    heightPerObject)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
