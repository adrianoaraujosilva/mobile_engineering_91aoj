import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/firebase/models/produto.dart';

class TableProdutosWidget extends StatelessWidget {
  const TableProdutosWidget({
    super.key,
    required this.editMode,
    required this.setCurrentIndex,
    required this.setProdutoList,
    required this.clearProdutoList,
    required this.updateTextControllers,
    required this.deleteProduto,
  });

  final void Function(bool visible) editMode;
  final void Function(int index) setCurrentIndex;
  final void Function(Produto produto) setProdutoList;
  final void Function() clearProdutoList;
  final void Function(Produto produto) updateTextControllers;
  final void Function(String? id) deleteProduto;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("produtos").snapshots(),
        builder: (context, snapshot) {
          List<Produto> produtoList = [];
          clearProdutoList();
          if (!snapshot.hasData) return const LinearProgressIndicator();
          final data = snapshot.data?.docs;
          for (var i in data!) {
            Produto produto = Produto(i.id, i.data()['compraId'],
                i.data()['nome'], i.data()['quantidade'], i.data()['preco']);
            produtoList.add(produto);
            setProdutoList(produto);
          }
          return DataTable(
            columnSpacing: 30.0,
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
                          editMode(true);
                          setCurrentIndex(produtoList.indexOf(produto));
                          updateTextControllers(produto);
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
                        onTap: () => deleteProduto(produto.id),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        });
  }
}
