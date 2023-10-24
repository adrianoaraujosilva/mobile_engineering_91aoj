import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/input.dart';
import 'package:persist_type/firebase/models/produto.dart';

class FormProdutosWidget extends StatelessWidget {
  FormProdutosWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _marcaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();

  _insertProduto(Produto produto) async {
    await FirebaseFirestore.instance
        .collection("produtos")
        .add(produto.toJson());
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Itens");
    return Scaffold(
        appBar: AppBar(
          title: title,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputWidget(
                      label: "Produto", inputController: _nomeController),
                  InputWidget(
                      label: "Marca", inputController: _marcaController),
                  InputWidget(
                      label: "Quantidade",
                      inputController: _quantidadeController),
                  InputWidget(
                      label: "Preço", inputController: _precoController),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: const Text("Salvar"),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // final car = Car(
                          //     _marcaController.text, _modeloController.text);
                          // _insertProduto(car);
                          print("aqui");
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        }
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
