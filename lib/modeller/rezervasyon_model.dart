import 'package:cloud_firestore/cloud_firestore.dart';

class RezervasyonModel {
  late String id;
  late String kullaniciid;
  late String saat;
  late num gun;
  late num ay;
  late num yil;

  RezervasyonModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = data['id'];
    kullaniciid = data['kullaniciid'];
    saat = data['saat'];
    gun = data['gun'];
    ay = data['ay'];
    yil = data['yil'];
  }
}
