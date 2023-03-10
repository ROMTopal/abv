import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skendy/src/screens/splash_screen/splash_screen.dart';

import 'package:skendy/src/utils/all_providers.dart';
import 'package:skendy/src/utils/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCRDSI_TPt-_rWZijLaHTWJQbMsMTQccz8",
      appId: "1:821903558639:android:cf9fa846d64a1639fc181a",
      messagingSenderId: "XXX",
      projectId: "skendy-17e9e",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: MyThemes.lightTheme,
          themeMode: themeProvider.themeMode,
          darkTheme: MyThemes.darkTheme,
          title: 'Skendy',
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
