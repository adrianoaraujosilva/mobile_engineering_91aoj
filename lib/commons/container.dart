import 'package:flutter/material.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/firebase/screens/form_produtos.dart';

class ContainerHomeWidget extends StatelessWidget {
  const ContainerHomeWidget({
    super.key,
    this.height,
    this.width,
    this.child,
    required this.compraId,
    required this.compraNome,
    this.compraData,
    required this.totalProdutos,
    required this.totalPreco,
  });

  final double? height;
  final double? width;
  final Widget? child;
  final String compraId;
  final String compraNome;
  final String? compraData;
  final int totalProdutos;
  final double totalPreco;

  @override
  Widget build(BuildContext context) {
    const boxShadow = [
      BoxShadow(
        color: Colors.black,
        spreadRadius: 0.5,
        offset: Offset(2.0, 2.0),
        blurRadius: 5.0,
      )
    ];
    const borderRadius = BorderRadius.all(Radius.circular(20.0));
    const textStyleTitle = TextStyle(
      fontSize: 20.0,
      color: Colors.brown,
      fontWeight: FontWeight.bold,
    );
    const textStyleSubTitle = TextStyle(
      fontSize: 18.0,
      color: Colors.orange,
    );
    String preco = totalPreco.toStringAsFixed(2);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormProdutosWidget(
            compraId: compraId,
            mercadoNome: compraNome,
            backPage: 1,
          ),
        ),
      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2 - 32,
        margin: edgeInsets16,
        padding: edgeInsets16,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mercado: $compraNome", style: textStyleTitle),
            Text("Data: $compraData", style: textStyleSubTitle),
            Text("$totalProdutos Produtos", style: textStyleSubTitle),
            Text("Total: R\$ $preco", style: textStyleSubTitle),
          ],
        ),
      ),
    );
  }
}
