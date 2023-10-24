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
  var _dataCompra = Timestamp.now();

  _insertCompra(Compra compra) async {
    await FirebaseFirestore.instance.collection("compras").add(compra.toJson());
  }

  Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
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
                    controller: _dataController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Informe a data"),
                    readOnly: true,
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
                        _dataCompra = Timestamp.fromDate(pickedDate);
                      } else {
                        print("Date is not selected");
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
                          final compra =
                              Compra(_mercadoController.text, _dataCompra);
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
