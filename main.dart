import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'hareket.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController title = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  var GelenyaziBasligi = "";
  var GelenyaziIcerigi = "";

  yaziEkle() {
    FirebaseFirestore.instance
        .collection("Cari")
        .doc(t1.text)
        .set({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Cari Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
    FirebaseFirestore.instance.collection("CariHareket").doc(t1.text).set(
        {'adsoy': t1.text}).whenComplete(() => print("Carihareket Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
  }

  CariEkle() {
    FirebaseFirestore.instance
        .collection("CariGercek")
        .doc(t1.text)
        .set({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Cari Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
    FirebaseFirestore.instance.collection("CariHareket").doc(t1.text).set(
        {'adsoy': t1.text}).whenComplete(() => print("Carihareket Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
  }

  guncelle() {
    FirebaseFirestore.instance
        .collection("Cari")
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("cari güncellendi"));
  }

  sil() {
    FirebaseFirestore.instance
        .collection("Cari")
        .doc(t1.text)
        .delete()
        .whenComplete(() => print("Cari silindi"));
    FirebaseFirestore.instance
        .collection("CariHarket")
        .doc(t1.text)
        .delete()
        .whenComplete(() => print("CariHarket silindi"));
  }

  oku() {
    FirebaseFirestore.instance
        .collection("Cari")
        .doc(t1.text)
        .get()
        .then((Gelenveri) {
      setState(() {
        GelenyaziBasligi = Gelenveri.data()!['baslik'];
        GelenyaziIcerigi = Gelenveri.data()!['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              TextField(
                controller: t3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: yaziEkle, child: Text("YAZI_EKLE")),
                      ElevatedButton(
                          onPressed: CariEkle, child: Text("GERÇEK CARİ EKLE")),
                      ElevatedButton(onPressed: oku, child: Text("OKU")),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: guncelle, child: Text("GUNCELLE")),
                      ElevatedButton(onPressed: sil, child: Text("DELETE")),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => hareket()));
                          },
                          child: Text("LİSTE")),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => hareket()));
                          },
                          child: Text("CARİ")),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(GelenyaziBasligi),
                subtitle: Text(GelenyaziIcerigi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
