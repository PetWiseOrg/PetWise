import 'package:petwise/ui/common_widgets/test_widgets/go_named_back_button_testing.dart';
import 'package:petwise/ui/common_widgets/themed_text_field.dart';
import 'package:petwise/ui/localization/string_extensions.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:petwise/ui/ui_authentication/widgets/login_register_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:petwise/data/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context, TextEditingController usernameController,
      TextEditingController passwordController) async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.authenticateUser(
            usernameController.text, passwordController.text);
        if (context.mounted) {
          context.goNamed(AppRoute.homePage.name);
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
  }

  void forgotPasswordRedirect(BuildContext context) {
    context.goNamed(AppRoute.forgotPassword.name);
  }

  void registerRedirect(BuildContext context) {
    context.goNamed(AppRoute.registrationPage.name);
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

    final signUpText = Text.rich(TextSpan(
        text: 'Don\'t have an account? '.hardcoded,
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: 'Register now'.hardcoded,
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
                          hintText: 'Email or Username'.hardcoded,
                          controller: usernameController,
                        ),
                        heightPerObject),
                    wrap(
                        ThemedTextField(
                          hintText: 'Password'.hardcoded,
                          obscureText: true,
                          controller: passwordController,
                        ),
                        heightPerObject),
                    wrap(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => forgotPasswordRedirect(context),
                              child: Text(
                                'Forgot Password?'.hardcoded,
                                style: clickableStyleMedium,
                              ),
                            ),
                          ],
                        ),
                        heightPerObject),
                    wrap(
                        LoginRegisterButton(
                          onTap: () => login(
                              context, usernameController, passwordController),
                          message: 'Login'.hardcoded,
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
                      onTap: () => registerRedirect(context),
                      child: signUpText,
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
