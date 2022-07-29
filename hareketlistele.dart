import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'hareketekle.dart';
import 'hareket.dart';

//import 'package:databasaran/main.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        /*
      title: "İsim Listesi",
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: hareket(),*/
        );
  }
}

class hareketlistele extends StatefulWidget {
  @override
  _hareketlisteleState createState() => _hareketlisteleState();
}

class _hareketlisteleState extends State<hareketlistele> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('CariHareket').snapshots();

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference CariHareketRef = _firestore.collection('CariHareket');
    var CariRef = FirebaseFirestore.instance.collection('Cari').doc('name');
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => main()));
        },
        child: Icon(
          Icons.add,
        ),
      ),*/
      //addnote fonksiyon atanmış, sayfa değiştiriyor
      appBar: AppBar(
        title: Text('HAREKET LİSTESİ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CariHareketRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          List<DocumentSnapshot> ListOfDocumentSnap = asyncSnapshot.data.docs;
          if (asyncSnapshot.hasError) {
            return Text("something is wrong");
          }
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: asyncSnapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            hareketekle(docid: asyncSnapshot.data!.docs[index]),
                      ),
                      //dokunulduğundan on top özelliği ile istenen işlemi yapar
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            //'${ListOfDocumentSnap[index]['name']}',
                            '${ListOfDocumentSnap[index]['adsoy']}',

                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '${ListOfDocumentSnap[index]['hareketdetay']}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
