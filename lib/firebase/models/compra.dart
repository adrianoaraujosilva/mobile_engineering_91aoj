import 'package:cloud_firestore/cloud_firestore.dart';

class Compra {
  final String mercado;
  final Timestamp data;

  DocumentReference? refence;

  Compra(this.mercado, this.data);

  Map<String, dynamic> toJson() => {
        "mercado": mercado,
        "data": data,
      };

  Compra.fromMap(Map<String, dynamic> map, {this.refence})
      : mercado = map["mercado"],
        data = map["data"];

  Compra.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refence: snapshot.reference);
}
