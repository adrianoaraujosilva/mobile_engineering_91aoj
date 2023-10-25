// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/firebase/screens/login.dart';

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
      // TODO: a implementação do login por e-mail no firebase está apresentando o erro
      // aparentemente por conta de um sistema de proteção(email-enumeration-protection)
      // e não conseguimos desativar a tempo de entregar a funcionalidade
      //
      // code:
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return HomeWidget();
      //     } else {
      //       return LoginPageWidget();
      //     }
      //   },
      // ),
    );
  }
}
