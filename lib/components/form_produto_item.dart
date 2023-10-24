import 'package:flutter/material.dart';

class FormProdutoItemWidget extends StatefulWidget {
  const FormProdutoItemWidget({super.key});

  @override
  State<FormProdutoItemWidget> createState() => _FormProdutoItemWidgetState();
}

class _FormProdutoItemWidgetState extends State<FormProdutoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dynamic TextFormFields'),
      ),
      body: Container(),
    );
  }
}
