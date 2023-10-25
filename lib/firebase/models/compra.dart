import 'package:cloud_firestore/cloud_firestore.dart';

class Compra {
  final String mercado;
  final Timestamp data;
  final String? id;

  DocumentReference? refence;

  Compra(this.mercado, this.data, this.id);

  Map<String, dynamic> toJson() => {
        "mercado": mercado,
        "data": data,
        "id": id,
      };

  Compra.fromMap(Map<String, dynamic> map, {this.refence})
      : mercado = map["mercado"],
        data = map["data"],
        id = map["id"];

  Compra.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refence: snapshot.reference);
}
