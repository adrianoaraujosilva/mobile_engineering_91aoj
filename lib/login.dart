import 'package:flutter/material.dart';

import 'commons/constants.dart';
import 'home.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key, required String title});

  @override
  State<LoginPageWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Usuário: '),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Senha: '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, informe a sua senha";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if ((userNameController.text == "adriano.araujo" ||
                                    userNameController.text ==
                                        "marcely.santello") &&
                                passwordController.text == "1234") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeWidget(
                                          username: userNameController.text,
                                        )),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
