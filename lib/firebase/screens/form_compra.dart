import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/helpers.dart';
import 'package:persist_type/firebase/models/compra.dart';
import 'package:persist_type/firebase/screens/form_produtos.dart';
import 'package:intl/intl.dart';

class FormCompraWidget extends StatelessWidget {
  FormCompraWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _mercadoController = TextEditingController();
  final _dataController = TextEditingController();
  final addRoute = FormProdutosWidget();

  _insertCompra(Compra compra) async {
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection("compras")
        .add(compra.toJson());
    return docRef.id;
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Nova compra");

    return Scaffold(
        appBar: AppBar(
          title: title,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.text_fields),
                        labelText: "Mercado",
                        hintText: "Nome do mercado"),
                    controller: _mercadoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mercado inválido";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Data",
                        hintText: "Data da compra"),
                    controller: _dataController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Data inválida";
                      }

                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          // locale: const Locale('pt-BR'),
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
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: const Text("Salvar"),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          final compra = Compra(_mercadoController.text,
                              convertStringToTimestamp(_dataController.text));
                          _insertCompra(compra);
                          // Navigator.pop(context, compra_id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addRoute));
                        }
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
