import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  final String compra_id;
  final String nome;
  final String marca;
  final int quantidade;
  final double preco;

  DocumentReference? refence;

  Produto(this.compra_id, this.nome, this.marca, this.quantidade, this.preco);

  Map<String, dynamic> toJson() => {
        "compra_id": compra_id,
        "nome": nome,
        "marca": marca,
        "quantidade": quantidade,
        "preco": marca,
      };

  Produto.fromMap(Map<String, dynamic> map, {this.refence})
      : compra_id = map["compra_id"],
        nome = map["nome"],
        marca = map["marca"],
        quantidade = map["quantidade"],
        preco = map["preco"];

  Produto.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refence: snapshot.reference);
}
