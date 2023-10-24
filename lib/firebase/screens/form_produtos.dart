import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Produto("1", "Detergente abxasdsadasd", 5, 2.58),
    Produto("1", "Amaciante", 2, 10.68),
    Produto("1", "Trakinas", 5, 1.72),
    Produto("1", "Detergente abxasdsadasd", 5, 2.58),
    Produto("1", "Amaciante", 2, 10.68),
    Produto("1", "Trakinas", 5, 1.72),
    Produto("1", "Detergente abxasdsadasd", 5, 2.58),
    Produto("1", "Amaciante", 2, 10.68),
    Produto("1", "Trakinas", 5, 1.72),
    Produto("1", "Detergente abxasdsadasd", 5, 2.58),
    Produto("1", "Amaciante", 2, 10.68),
    Produto("1", "Trakinas", 5, 1.72),
  ];

  @override
  Widget build(BuildContext context) {
    Widget bodyData() => DataTable(
          columnSpacing: 30.0,
          onSelectAll: (b) {},
          sortColumnIndex: 0,
          sortAscending: true,
          columns: const <DataColumn>[
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Qtd.")),
            DataColumn(label: Text("Preco")),
            DataColumn(label: Text("")),
            DataColumn(label: Text("")),
          ],
          rows: produtoList
              .map(
                (produto) => DataRow(
                  cells: [
                    DataCell(
                      Text(produto.nome),
                    ),
                    DataCell(
                      Text(produto.quantidade.toString()),
                    ),
                    DataCell(
                      Text(produto.preco.toString()),
                    ),
                    DataCell(
                      const SizedBox(
                        width: 10,
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        currentIndex = produtoList.indexOf(produto);
                        _updateTextControllers(produto); //
                      },
                    ),
                    DataCell(
                      const SizedBox(
                        width: 10,
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        currentIndex = produtoList.indexOf(produto);
                        _deleteTextControllers(); // new function here
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data add to List Table using Form"),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        labelText: 'Nome',
                        hintText: 'Nome do produto',
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: quantidadeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      autocorrect: false,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Quantidade',
                        hintText: 'Quantidade',
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: precoController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      autocorrect: false,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Preço',
                        hintText: 'Preço',
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid),
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
                                  print(validate());
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
            bodyData(),
          ],
        ),
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
      produtoList.removeAt(currentIndex);
    });
  }

  void addProdutoToList(nome, quantidade, preco) {
    setState(() {
      produtoList.add(
          Produto("123", nome, int.parse(quantidade), double.parse(preco)));
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
