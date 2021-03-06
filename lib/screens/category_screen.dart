import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tile/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(indicatorColor: Colors.white, tabs: <Widget>[
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ]),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("produtos")
                .document(snapshot.documentID)
                .collection("itens")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(physics: NeverScrollableScrollPhysics(),
                    //Comando para bloquear o movimento lateral da tela
                    children: [
                      //GridView.builder é utilizado para ir carregando aos poucos os produtos para nao pesar a tela
                      GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //Quantidade de produtos na vertical (Cross = Vertical --- Main = Horizontal)
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.65,
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                "grid",
                                ProductData.fromDocument(
                                    snapshot.data.documents[index]));
                          }),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return ProductTile(
                                "list",
                                ProductData.fromDocument(
                                    snapshot.data.documents[index]));
                          }),
                    ]);
              }
            },
          )),
    );
  }
}
