import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/input.dart';
import 'package:persist_type/firebase/models/car.dart';

class FormCarWidget extends StatelessWidget {
  FormCarWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();

  _insertCar(Car c) async {
    await FirebaseFirestore.instance.collection("cars").add(c.toJson());
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Novo carro");
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
                      label: "Marca", inputController: _marcaController),
                  InputWidget(
                      label: "Modelo", inputController: _modeloController),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ElevatedButton(
                      child: const Text("Salvar"),
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          final car = Car(
                              _marcaController.text, _modeloController.text);
                          _insertCar(car);
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
