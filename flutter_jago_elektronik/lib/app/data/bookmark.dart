import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkFirestore {
  final CollectionReference _bookmarkCollection =
      FirebaseFirestore.instance.collection('save');
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> deleteBookmark({
    required String user,
    required String product,
  }) async {
    var result = await _bookmarkCollection.get();
    result = await _bookmarkCollection
        .orderBy('user_id')
        .startAt([user]).endAt(['$user\uf8ff']).get();

    for (var doc in result.docs) {
      var bookmark = doc.data() as Map<String, dynamic>;
      if (bookmark.containsKey('product_id')) {
        if (bookmark['product_id'] == product) {
          await doc.reference.delete();
          break;
        }
      }
    }
  }

  Future<void> addBookmark({
    required String user,
    required String product,
  }) async {
    var doc = _bookmarkCollection.doc();
    await doc.set({
      'user_id': user,
      'product_id': product,
    });
  }

  Future<bool> isBookmark({
    required String user,
    required String product,
  }) async {
    var result = await _bookmarkCollection.get();
    result = await _bookmarkCollection
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

  Future<List<ProductData>> getBookmarks({
    required String user,
  }) async {
    List<ProductData> data = [];
    var result = await _bookmarkCollection.get();
    result = await _bookmarkCollection
        .orderBy('user_id')
        .startAt([user]).endAt(['$user\uf8ff']).get();

    for (var doc in result.docs) {
      var bookmark = doc.data() as Map<String, dynamic>;
      if (bookmark.containsKey('product_id')) {
        var product =
            await _productCollection.doc(bookmark['product_id']).get();

        var mData =
            ProductData.fromJson(product.data() as Map<String, dynamic>);
        mData.id = product.id;
        data.add(mData);
      }
    }

    return data;
  }
}
