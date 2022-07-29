import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'hareketekle.dart';

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

class hareket extends StatefulWidget {
  
  @override
  _hareketState createState() => _hareketState();
}

class _hareketState extends State<hareket> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Cari').snapshots();



  @override
  Widget build(BuildContext context) {
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
        title: Text('İSİM LİSTESİ'),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            hareketekle(docid: snapshot.data!.docs[index]),
                      ),
                      //dokunulduğunda on top özelliği ile istenen işlemi yapar
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
                            snapshot.data!.docChanges[index].doc['baslik'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['icerik'],
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
