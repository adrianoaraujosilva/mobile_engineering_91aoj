import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:persist_type/floor/screens/list_books.dart';
// import 'package:persist_type/firebase/screens/list_cars.dart';
import 'package:persist_type/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const HomeWidget(),
        // "/books": (context) => const ListBooksWidget(),
        // "/cars": (context) => const ListCarsWidget(),
      },
      initialRoute: "/",
    );
  }
}
