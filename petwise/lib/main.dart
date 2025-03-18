import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petwise/data/providers/user_provider.dart';
import 'package:petwise/data/repositories/user_repo.dart';
import 'package:petwise/data/repositories/pet_repo.dart';
import 'package:petwise/data/providers/pet_provider.dart';
import 'package:petwise/data/repositories/pet_user_repo.dart';
import 'package:petwise/data/providers/pet_user_provider.dart';
import 'package:petwise/data/repositories/vet_user_repo.dart';
import 'package:petwise/data/providers/vet_user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String apiURl = const String.fromEnvironment('URL', defaultValue: 'http://10.0.2.2:8090');

  // create authstore to store credentials and retrieve stored credentials

  //create SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  //create AsyncAuthStore instance
  final store = AsyncAuthStore(
    save: (String data) async => prefs.setString('pb_auth', data),
    initial: prefs.getString('pb_auth'),
  );

  // Initialize PocketBase with the API URL
  final pb = PocketBase(apiURl, authStore: store);

  runApp(
    MultiProvider(
      providers: [
        // pocketbase provider
        Provider<PocketBase>.value(value: pb),

        // user repository provider
        Provider<UserRepository>(create: (_) => UserRepository.getInstance(pb),),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),

        //petUser repository provider
        Provider<PetUserRepository>.value(value: PetUserRepository.getInstance(pb)),
        ChangeNotifierProvider<PetUserProvider>(
          create: (context) => PetUserProvider(
            Provider.of<PetUserRepository>(context, listen: false),
          ),
        ),

        // pet repository provider
        Provider<PetRepository>.value(value: PetRepository.getInstance(pb)),
        ChangeNotifierProvider<PetProvider>(
          create: (context) => PetProvider(
            Provider.of<PetRepository>(context, listen: false),
          ),
        ),

        //vetUser repository provider
        Provider<VetUserRepository>.value(value: VetUserRepository.getInstance(pb)),
        ChangeNotifierProvider<VetUserProvider>(
          create: (context) => VetUserProvider(
            Provider.of<VetUserRepository>(context, listen: false),
          ),
        ),
      ],
      child: const PetWise(),
    ),
  );
}

class PetWise extends StatelessWidget {
  const PetWise({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: petwiseTheme,
    );
  }
}
