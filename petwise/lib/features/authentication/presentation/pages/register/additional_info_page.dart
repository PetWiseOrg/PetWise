import 'dart:io';

import 'package:petwise/core/common_widgets/themed_text_field.dart';
import 'package:petwise/core/localization/string_extensions.dart';
import 'package:petwise/core/navigation/routing.dart';
import 'package:petwise/core/theme/app_theme.dart';
import 'package:petwise/features/authentication/presentation/widgets/login_register_button.dart';
import 'package:petwise/features/authentication/domain/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({super.key});

  @override
  State<AdditionalInfoPage> createState() => AdditionalInfoPageState();
}

class AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  XFile? profileImage; // Add this variable

  Future<void> updateProfile(BuildContext context, String username,
      String phoneNumber, XFile profileImage) async {
    if (username.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields'.hardcoded)),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id ?? '';

    final body = {
      'username': username,
      'phoneNumber': phoneNumber,
    };

    try {
      await authProvider.updateUserProfile(userId, body, profileImage);
      if (mounted) {
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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
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

    return Scaffold(
      appBar: null,
      body: Center(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              wrap(
                  Text('Finish your Profile Setup'.hardcoded,
                      style: Theme.of(context).textTheme.headlineSmall),
                  heightPerObject),
              wrap(
                const SizedBox(height: 20), // Add spacing
                heightPerObject,
              ),
              wrap(
                GestureDetector(
                  onTap: pickImage,
                  child: profileImage == null
                      ? Text('Pick Profile Image'.hardcoded,
                          style: Theme.of(context).textTheme.bodyMedium)
                      : ClipOval(
                          child: Image.file(
                            File(profileImage!.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                100,
              ),
              wrap(
                const SizedBox(height: 20), // Add spacing
                heightPerObject,
              ),
              wrap(
                  ThemedTextField(
                    hintText: 'Username'.hardcoded,
                    controller: usernameController,
                  ),
                  heightPerObject),
              wrap(
                  ThemedTextField(
                    hintText: 'Phone Number'.hardcoded,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                  ),
                  heightPerObject),
              wrap(
                  LoginRegisterButton(
                    onTap: () {
                      updateProfile(
                          context,
                          usernameController.text,
                          phoneNumberController.text,
                          profileImage ?? XFile(''));
                    },
                    message: 'Update Profile'.hardcoded,
                    textStyle: titleStyleMedium,
                    padding: 4,
                    elevation: 4,
                  ),
                  heightPerObject),
            ],
          ),
        ),
      ),
    );
  }
}
