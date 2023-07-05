import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_serba_ada/screens/productsDetail.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  final String url = 'http://127.0.0.1:8000/api/products';
//http://10.0.2.2:8000/api/products
  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
        appBar: AppBar(
          title: Text('toko serba ada'),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: snapshot.data['data']
                                                  [index],
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 120,
                                  width: 120,
                                  child: Image.network(
                                      snapshot.data['data'][index]['image_url'],
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['name'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]
                                            ['description'],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.price_change),
                                        Text(
                                          snapshot.data['data'][index]['price']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
