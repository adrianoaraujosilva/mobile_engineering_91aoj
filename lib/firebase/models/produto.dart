import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  final String compraId;
  final String nome;
  final int quantidade;
  final double preco;

  DocumentReference? refence;

  Produto(this.compraId, this.nome, this.quantidade, this.preco);

  Map<String, dynamic> toJson() => {
        "compraId": compraId,
        "nome": nome,
        "quantidade": quantidade,
        "preco": preco,
      };

  Produto.fromMap(Map<String, dynamic> map, {this.refence})
      : compraId = map["compra_id"],
        nome = map["nome"],
        quantidade = map["quantidade"],
        preco = map["preco"];

  Produto.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refence: snapshot.reference);
}
