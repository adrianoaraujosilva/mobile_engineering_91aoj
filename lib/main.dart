import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/home.dart';
import 'package:persist_type/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const LoginPageWidget(),
      },
      initialRoute: "/",
    );
  }
}
