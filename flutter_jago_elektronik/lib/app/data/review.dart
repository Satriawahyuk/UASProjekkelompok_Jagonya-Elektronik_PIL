import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewFirestore {
  final CollectionReference _reviewCollection =
      FirebaseFirestore.instance.collection('reviews');
final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');
      
  Future<void> addReview({
    required String user,
    required int rating,
    required String product,
  }) async {
    var doc = _reviewCollection.doc();
    await doc.set({
      'user_id': user,
      'star': rating,
      'product_id': product,
    });

    var pDoc = _productCollection.doc(product);
    var result = await pDoc.get();
    var data = (result.data() as Map<String, dynamic>);
    data['total_start'] += rating;
    data['total_review'] += 1;

    await pDoc.update(data);
  }

  Future<bool> hasReview({
    required String user,
    required String product,
  }) async {
    var result = await _reviewCollection.get();
    result = await _reviewCollection
        .orderBy('user_id')
        .startAt([user]).endAt(['$user\uf8ff']).get();

    for (var doc in result.docs) {
      var bookmark = doc.data() as Map<String, dynamic>;
      if (bookmark.containsKey('product_id')) {
        if (bookmark['product_id'] == product) {
          return true;
        }
      }
    }

    return false;
  }
}
