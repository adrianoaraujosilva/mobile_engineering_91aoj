import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String marca;
  final String modelo;

  DocumentReference? refence;

  Car(this.marca, this.modelo);

  Map<String, dynamic> toJson() => {
        "marca": marca,
        "modelo": modelo,
      };

  Car.fromMap(Map<String, dynamic> map, {this.refence})
      : marca = map["marca"],
        modelo = map["modelo"];

  Car.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refence: snapshot.reference);
}
