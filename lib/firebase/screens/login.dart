// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../commons/constants.dart';
import '../../home.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  final _formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const loginPage = Text('Login');
    const homePage = HomeWidget();

    return Scaffold(
      appBar: AppBar(
        title: loginPage,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Usuário: ',
                    suffixIcon: IconButton(
                      onPressed: userNameController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, informe o seu usuário";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha: ',
                    suffixIcon: IconButton(
                      onPressed: passwordController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, informe a sua senha";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    // TODO: problema com sistema de segurança no Firebase
                    //onPressed: signIn,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Usuários MOCK para testes
                        if ((userNameController.text == "marcely.santello" ||
                                userNameController.text == "adriano.araujo" ||
                                userNameController.text == "prof") &&
                            passwordController.text == "1234") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => homePage),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Credenciais inválidas')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Por favor, preencha corretamente as credenciais")),
                        );
                      }
                    },
                    child: btnLogar,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // TODO: problema com sistema de segurança no Firebase
  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: userNameController.text.trim(),
  //         password: passwordController.text.trim());
  //   } on FirebaseAuthException catch (error) {
  //     return error.toString();
  //   }
  // }
}
