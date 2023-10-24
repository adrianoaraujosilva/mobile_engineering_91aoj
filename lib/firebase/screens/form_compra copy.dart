import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/input.dart';
import 'package:persist_type/firebase/models/compra.dart';
import 'package:intl/intl.dart';

class FormCompraWidget extends StatelessWidget {
  FormCompraWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _mercadoController = TextEditingController();
  final _dataController = TextEditingController();

  _insertCompra(Compra compra) async {
    await FirebaseFirestore.instance.collection("compras").add(compra.toJson());
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
                  InputWidget(
                      label: "Mercado", inputController: _mercadoController),
                  TextField(
                    controller:
                        _dataController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);
                        _dataController.text = formattedDate;
                        _dataController.text = formattedDate;
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  // InputWidget(
                  //     label: "Modelo", inputController: _dataController),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: const Text("Salvar"),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          final compra = Compra(
                              // _mercadoController.text, _dataController.text);
                              _mercadoController.text,
                              _dataController.text);
                          _insertCompra(compra);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
