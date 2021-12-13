import 'package:cloud_firestore/cloud_firestore.dart';

class SalonModel {
  late String id;
  late int kapasite;
  late String isim;

  SalonModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as dynamic;
    id = data['id'];
    kapasite = data['kapasite'];
    isim = data['isim'];
  }
}
