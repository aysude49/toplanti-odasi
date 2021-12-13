import 'package:cloud_firestore/cloud_firestore.dart';

class KullaniciModel {
  static late String uid;
  static late String isim;
  static late String soyisim;
  static late String mail;
  static late String telefon;

  KullaniciModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    uid = data['uid'];
    isim = data['isim'];
    soyisim = data['soyisim'];
    mail = data['mail'];
    telefon = data['telefon'];
  }
}
