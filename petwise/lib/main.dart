import 'package:petwise/navigation/routing.dart';
import 'package:petwise/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:petwise/ui/pet_owner/pet/presentation/pages/pet_owner_provider_class.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petwise/data/providers/user_provider.dart';
import 'package:petwise/data/repositories/user_repo.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // Remove this import

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

  // get pb instance in any widget using provider
  //import 'package:pocketbase/pocketbase.dart';
  //import 'package:provider/provider.dart';
  //final pb = Provider.of<PocketBase>(context);

  // Check if the stored credentials are valid
  //pb.authStore.isValid();

  runApp(
    MultiProvider(
      providers: [
        Provider<PocketBase>.value(value: pb),
        Provider<UserRepository>(
          create: (_) => UserRepository.getInstance(pb),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<PetOwnerProvider>(
          create: (_) => PetOwnerProvider(),
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
