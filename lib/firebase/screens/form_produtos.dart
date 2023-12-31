import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/commons/input.dart';
import 'package:persist_type/components/table_produtos_component.dart';
import 'package:persist_type/firebase/models/produto.dart';

class FormProdutosWidget extends StatefulWidget {
  FormProdutosWidget({
    Key? key,
    required this.compraId,
    required this.mercadoNome,
    required this.backPage,
  }) : super(key: key);

  final String compraId;
  final String mercadoNome;
  final int backPage;

  @override
  State<FormProdutosWidget> createState() => _FormProdutosWidgetState();
}

class _FormProdutosWidgetState extends State<FormProdutosWidget> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController precoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static final _focusNode = FocusNode();
  List<Produto> produtoList = [];
  int currentIndex = 0;
  bool visibleAdd = true;
  bool visibleEdit = false;

  _insertProduto(Produto produto) async => await FirebaseFirestore.instance
      .collection("produtos")
      .add(produto.toJson());

  _updateProduto(Produto produto) async => await FirebaseFirestore.instance
      .collection("produtos")
      .doc(produto.id)
      .update(produto.toJson());

  _deleteProduto(String? id) async =>
      await FirebaseFirestore.instance.collection("produtos").doc(id).delete();

  _setCurrentIndex(int index) => currentIndex = index;
  _setProdutoList(Produto produto) => produtoList.add(produto);
  _clearProdutoList() => produtoList.clear();
  _editMode(bool visible) {
    setState(() {
      visibleAdd = !visible;
      visibleEdit = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text("${widget.mercadoNome} - Lista de produtos");
    const textCancel = Text("Cancelar");
    const textAdd = Text("Adicionar");
    const textEdit = Text("Atualizar");

    return Scaffold(
      appBar: AppBar(
        title: pageTitle,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= widget.backPage);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: edgeInsets,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    InputWidget(
                      label: "Nome",
                      inputController: nomeController,
                      autoFocus: true,
                      focusNode: _focusNode,
                    ),
                    sizedBoxH10,
                    InputWidget(
                      label: "Quantidade",
                      inputController: quantidadeController,
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      icon: iconNumber,
                    ),
                    sizedBoxH10,
                    InputWidget(
                      label: "Preço",
                      inputController: precoController,
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      icon: iconCurrency,
                    ),
                    sizedBoxH10,
                    Column(
                      children: <Widget>[
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Visibility(
                                visible: visibleAdd,
                                child: TextButton(
                                  child: textAdd,
                                  onPressed: () {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      addProdutoToList(
                                          nomeController.text,
                                          quantidadeController.text,
                                          precoController.text);
                                      clearForm();
                                    }
                                  },
                                ),
                              ),
                              Visibility(
                                visible: visibleEdit,
                                child: TextButton(
                                  child: textEdit,
                                  onPressed: () {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      updateForm();
                                      clearForm();
                                    }
                                  },
                                ),
                              ),
                              TextButton(
                                  child: textCancel,
                                  onPressed: () => clearForm()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TableProdutosWidget(
              compraId: widget.compraId,
              editMode: _editMode,
              setCurrentIndex: _setCurrentIndex,
              setProdutoList: _setProdutoList,
              clearProdutoList: _clearProdutoList,
              updateTextControllers: _updateTextControllers,
              deleteProduto: _deleteProduto,
            ),
          ],
        ),
      ),
    );
  }

  _updateTextControllers(Produto produto) {
    setState(() {
      nomeController.text = produto.nome;
      quantidadeController.text = produto.quantidade.toString();
      precoController.text = produto.preco.toString();
    });
  }

  void updateForm() => _updateProduto(Produto(
      produtoList[currentIndex].id,
      widget.compraId,
      nomeController.text,
      int.parse(quantidadeController.text),
      double.parse(precoController.text)));

  void addProdutoToList(nome, quantidade, preco) {
    final produto = Produto(null, widget.compraId, nome, int.parse(quantidade),
        double.parse(preco));
    _insertProduto(produto);
  }

  void clearForm() {
    _editMode(false);
    _focusNode.requestFocus();
    nomeController.clear();
    quantidadeController.clear();
    precoController.clear();
  }
}
