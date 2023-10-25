import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/commons/helpers.dart';
import 'package:persist_type/commons/input.dart';
import 'package:persist_type/firebase/models/compra.dart';
import 'package:persist_type/firebase/screens/form_produtos.dart';
import 'package:intl/intl.dart';

class FormCompraWidget extends StatelessWidget {
  FormCompraWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _mercadoController = TextEditingController();
  final _dataController = TextEditingController();

  _insertCompra(Compra compra) async {
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection("compras")
        .add(compra.toJson());

    return docRef.id;
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Nova compra");
    const textSalvar = Text("Salvar");

    return Scaffold(
      appBar: AppBar(title: title),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: edgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputWidget(
                label: "Mercado",
                inputController: _mercadoController,
                icon: iconText,
              ),
              InputWidget(
                label: "Data da compra",
                inputController: _dataController,
                icon: iconCalendar,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _dataController.text = formattedDate;
                  }
                },
              ),
              Padding(
                padding: edgeInsets,
                child: ElevatedButton(
                  child: textSalvar,
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      final navigator = Navigator.of(context);
                      final compra = Compra(_mercadoController.text,
                          convertStringToTimestamp(_dataController.text), "");
                      final compraId = await _insertCompra(compra);

                      if (compraId != null) {
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => FormProdutosWidget(
                              compraId: compraId,
                              mercadoNome: _mercadoController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
