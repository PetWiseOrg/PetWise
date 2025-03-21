import 'dart:io';

import 'package:petwise/ui/common_widgets/themed_text_field.dart';
import 'package:petwise/ui/localization/string_extensions.dart';
import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:petwise/ui/ui_authentication/widgets/login_register_button.dart';
import 'package:petwise/data/providers/user_provider.dart';
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
  //final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  //userType, can be Vet (vetUser) or Pet Owner (petUser)
  final userTypeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  XFile? profileImage; // Add this variable

  //prefill controllers with data from authProvider
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final user = authProvider.currentUser;

    if (user != null) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      userTypeController.text = user.userType ?? '';
      phoneNumberController.text = user.phoneNumber ?? '';
    }
  }

  Future<void> updateProfile(BuildContext context, String firstName, String lastName, String userType, String phoneNumber, XFile profileImage) async {
    if (firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || userType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields'.hardcoded)),
      );
      return;
    }

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id ?? '';

    final body = {
      'firstName': firstName,
      'lastName': lastName,
      'userType': userType,
      'phoneNumber': phoneNumber,
      'isFullyCreated': true,
    };

    try {
      await authProvider.updateUserProfile(userId, body, profileImage);
      if (mounted) {
        if (authProvider.currentUser!.userType == 'Vet') {
          //context.goNamed(AppRoute.vetDashboardPage.name);
        } else {
          context.goNamed(AppRoute.petOwnerDashboardPage.name);
        }
      }
    } catch (error) {
      if (!mounted) return;
      final errorString = error.toString();
      final start = errorString.indexOf('message:');
      final end = errorString.indexOf(",", start);
      final message = errorString.substring(start + 9, end);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of a text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80), // Add top padding like in login page
                  wrap(Text('Finish your Profile Setup'.hardcoded, style: Theme.of(context).textTheme.headlineSmall), heightPerObject),
                  wrap(
                    const SizedBox(height: 20),
                    heightPerObject,
                  ),
                  wrap(
                    GestureDetector(
                      onTap: pickImage,
                      child: Column(
                        children: [
                          profileImage == null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.grey[700],
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(profileImage!.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(height: 10),
                          Text(
                            'Pick a Profile Image'.hardcoded,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    130,
                  ),
                  wrap(
                    const SizedBox(height: 20), // Add spacing
                    heightPerObject,
                  ),
                  wrap(
                    DropdownMenu<String>(
                      width: width,
                      hintText: 'What Type of user are you?',
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<String>(value: 'petUser', label: "Pet Owner"),
                        DropdownMenuEntry<String>(value: 'vetUser', label: "Veterinarian"),
                      ],
                      onSelected: (value) {
                        userTypeController.text = value ?? '';
                      },
                    ),
                    heightPerObject,
                  ),
                  wrap(
                      ThemedTextField(
                        hintText: 'First Name'.hardcoded,
                        controller: firstNameController,
                      ),
                      heightPerObject),
                  wrap(
                      ThemedTextField(
                        hintText: 'Last Name'.hardcoded,
                        controller: lastNameController,
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
                          updateProfile(context, firstNameController.text, lastNameController.text, userTypeController.text, phoneNumberController.text, profileImage ?? XFile(''));
                        },
                        message: 'Update Profile'.hardcoded,
                        textStyle: titleStyleMedium,
                        padding: 4,
                        elevation: 4,
                      ),
                      heightPerObject),
                  const SizedBox(height: 40), // Add bottom padding to ensure scrollability
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
