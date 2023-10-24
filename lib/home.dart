import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/commons/helpers.dart';
import 'package:persist_type/commons/list_item.dart';
import 'package:persist_type/firebase/models/compra.dart';
import 'package:persist_type/firebase/screens/form_compra.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Compra> compras = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Compras");
    final addRoute = FormCompraWidget();

    return Scaffold(
        appBar: AppBar(
          title: title,
          actions: [
            IconButton(
                icon: addIcon,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addRoute));
                })
          ],
        ),
        body: buildList(context));
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("compras").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null || snapshot.data!.size == 0) {
            return const Center(child: Text("Nenhum compra localizada!"));
          } else {
            return buildListView(context, snapshot.data!.docs);
          }
        });
  }

  Widget buildListView(
      BuildContext context, List<QueryDocumentSnapshot> snapshots) {
    return ListView(
        padding: const EdgeInsets.only(top: 30),
        children: snapshots.map((data) => _buildItem(context, data)).toList());
  }

  Widget _buildItem(BuildContext context, QueryDocumentSnapshot data) {
    Compra compra = Compra.fromSnapshot(data);
    return Padding(
        padding: const EdgeInsets.all(12),
        child: ListItemWidget(
          leading: "",
          title: compra.mercado,
          subtitle: formatTimestamp(compra.data),
          onLongPress: () async {
            await data.reference.delete();
          },
        ));
  }
}
