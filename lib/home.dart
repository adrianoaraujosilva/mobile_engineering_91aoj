import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/commons/container.dart';
import 'package:persist_type/commons/helpers.dart';
import 'package:persist_type/commons/sized_box.dart';
import 'package:persist_type/firebase/models/compra.dart';
import 'package:persist_type/firebase/screens/form_compra.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, required this.username});

  final String username;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Home");
    final addRoute = FormCompraWidget();

    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
            icon: addIcon,
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addRoute))
                  .then((_) => setState(() {}));
            },
          )
        ],
      ),
      body: buildList(context),
    );
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
      },
    );
  }

  Widget buildListView(
      BuildContext context, List<QueryDocumentSnapshot> snapshots) {
    const edgeInsetsL16 = EdgeInsets.only(left: 16.0, top: 20.0);

    List<Widget> sizedBoxWidget = [
      Container(
        padding: edgeInsetsL16,
        child: Text("Compras",
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
      ),
    ];

    snapshots.map((data) {
      sizedBoxWidget.add(_buildItem(context, data));
    }).toList();

    snapshots.map((data) => _buildItem(context, data)).toList();

    return SizedBoxWidget(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(children: sizedBoxWidget),
    );
  }

  Widget _buildItem(BuildContext context, QueryDocumentSnapshot data) {
    Compra compra = Compra.fromSnapshot(data);

    // double totalNumber = 0;
    // _getProdutos(totalNumber);

    // print("_buildItem: $totalNumber");

    return ContainerHomeWidget(
      compraNome: compra.mercado,
      compraData: formatTimestamp(compra.data),
      totalProdutos: 10,
      totalPreco: 150.00,
    );
  }

  // _getProdutos(double totalNumber) async {
  //   var produtos = await FirebaseFirestore.instance
  //       .collection('produtos')
  //       // .where('date', isGreaterThan: DateTime.now())
  //       // .where('date', isGreaterThan: DateTime.parse(widget.searchTrip.date))
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     int numTransactions = querySnapshot.docs.length;
  //     print('Total transactions for today: $numTransactions');

  //     int totalTxnAmt = querySnapshot.docs
  //         .fold(0, (acc, doc) => acc + (doc['txnAmount'] ?? 0))
  //         .toInt();

  //     print('Total txnAmt for today: $totalTxnAmt');
  //   });
  //   //     .then((snapshot) {
  //   //   double totalNumber = 0;
  //   //   List<QueryDocumentSnapshot> _allTrips = snapshot.docs;
  //   //   _allTrips.forEach((element) => print(element.data()["preco"]));

  //   //   // _allTrips.forEach((element) => totalNumber += element.data()['seats']);
  //   // });
  // }
}
