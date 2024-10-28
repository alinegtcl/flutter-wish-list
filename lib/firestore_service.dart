import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wish_list/wish.dart';

class FirestoreService {
  final CollectionReference _wishlistCollection =
      FirebaseFirestore.instance.collection('wishlist');

  Future<void> addWish(Wish wish) async {
    await _wishlistCollection.add(wish.toMap());
  }

  Future<List<Wish>> getAllWishes() async {
    QuerySnapshot snapshot = await _wishlistCollection.get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Wish.fromMap(data..['id'] = doc.id);
    }).toList();
  }

  Future<void> deleteWish(String id) async {
    await _wishlistCollection.doc(id).delete();
  }
}
