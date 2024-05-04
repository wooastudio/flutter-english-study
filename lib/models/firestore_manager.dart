import 'package:cloud_firestore/cloud_firestore.dart';

// https://github.com/icodingchef/firestore_lec/blob/master/lib/firestore_page.dart

class FirestoreManager {
  static Future<void> update(CollectionReference product,
      DocumentSnapshot documentSnapshot, String ko, String eng) async {
    await product.doc(documentSnapshot.id).update({"ko": ko, "eng": eng});
  }

  static Future<void> create(
      CollectionReference product, String ko, String eng) async {
    await product.add(
      {'ko': ko, 'eng': eng},
    );
  }

  static Future<void> delete(
      CollectionReference product, String productId) async {
    await product.doc(productId).delete();
  }
}
