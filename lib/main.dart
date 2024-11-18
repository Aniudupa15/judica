import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:judica/auth/auth.dart';
import 'package:judica/auth/firebase_options.dart';
import 'package:judica/user_home.dart';
import 'package:judica/slpash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authpage(),
    );
}
}