import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  static Future<void> update(
      CollectionReference product, DocumentSnapshot documentSnapshot) async {}

  static Future<void> create(
      CollectionReference product, String ko, String eng) async {
    await product.add(
      {'ko': ko, 'eng': eng},
    );
  }
}
