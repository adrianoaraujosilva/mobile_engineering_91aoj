import 'package:flutter/material.dart';
import 'package:persist_type/firebase/models/produto.dart';

class FormProdutosWidget extends StatefulWidget {
  const FormProdutosWidget({super.key});

  @override
  State<FormProdutosWidget> createState() => _FormProdutosWidgetState();
}

class _FormProdutosWidgetState extends State<FormProdutosWidget> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  final form = GlobalKey<FormState>();
  static final _focusNode = FocusNode();
  bool update = false;
  int currentIndex = 0;

  List<Produto> produtoList = [
    Produto("1", "Detergente", 5, 2.58),
    Produto("1", "Amaciante", 2, 10.68),
    Produto("1", "Trakinas", 5, 1.72),
  ];

  @override
  Widget build(BuildContext context) {
    Widget bodyData() => DataTable(
          onSelectAll: (b) {},
          sortColumnIndex: 0,
          sortAscending: true,
          columns: const <DataColumn>[
            DataColumn(label: Text("Nome"), tooltip: "To Display name"),
            DataColumn(label: Text("Quantidade"), tooltip: "To Display Email"),
            DataColumn(label: Text("Preco"), tooltip: "To Display Email"),
            DataColumn(label: Text("Update"), tooltip: "Update data"),
            DataColumn(label: Text("Delete"), tooltip: "Delete data"),
          ],
          rows: produtoList
              .map(
                (produto) => DataRow(
                  cells: [
                    DataCell(
                      Text(produto.nome),
                    ),
                    DataCell(
                      Text(produto.preco.toString()),
                    ),
                    DataCell(
                      Text(produto.quantidade.toString()),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          currentIndex = produtoList.indexOf(produto);
                          _updateTextControllers(produto); // new function here
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          currentIndex = produtoList.indexOf(produto);
                          _deleteTextControllers(); // new function here
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data add to List Table using Form"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          bodyData(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nomeController,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                      labelStyle:
                          TextStyle(decorationStyle: TextDecorationStyle.solid),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextButton(
                              child: const Text("Add"),
                              onPressed: () {
                                if (validate() == true) {
                                  form.currentState?.save();
                                  addProdutoToList(
                                      nomeController.text,
                                      quantidadeController.text,
                                      precoController.text);
                                  clearForm();
                                }
                              },
                            ),
                            TextButton(
                              child: const Text("Update"),
                              onPressed: () {
                                if (validate() == true) {
                                  form.currentState?.save();
                                  updateForm();
                                  clearForm();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateForm() {
    setState(() {
      //Code to update the list after editing
      Produto produto = Produto(
          "123",
          nomeController.text,
          int.parse(quantidadeController.text),
          double.parse(precoController.text));
      produtoList[currentIndex] = produto;
    });
  }

  void _updateTextControllers(Produto produto) {
    setState(() {
      nomeController.text = produto.nome;
      quantidadeController.text = produto.quantidade.toString();
      precoController.text = produto.preco.toString();
    });
  }

  void _deleteTextControllers() {
    setState(() {
      //How to delete the list data on clicking Delete button?
      produtoList.removeAt(currentIndex);
    });
  }

  void addProdutoToList(nome, quantidade, preco) {
    setState(() {
      produtoList.add(Produto("123", nome, quantidade, preco));
    });
  }

  clearForm() {
    nomeController.clear();
    quantidadeController.clear();
    precoController.clear();
  }

  bool validate() {
    var valid = form.currentState!.validate();
    if (valid == true) form.currentState?.save();
    return valid;
  }
}
