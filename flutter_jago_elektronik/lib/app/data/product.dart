import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/data/model/detail_product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductFirestore {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference _productDetailCollection =
      FirebaseFirestore.instance.collection('details_product');
  final _storage = FirebaseStorage.instance;

  Future<void> deleteProduct({required String id}) async {
    var result = _productCollection.doc(id);

    await result.get().then((value) async {
      var photo = (value.data() as Map<String, dynamic>)['photo'];
      await _storage.refFromURL(photo).delete();
    });

    await result.delete();

    var dDoc = _productDetailCollection
        .orderBy('product_id')
        .startAt([id]).endAt(['$id\uf8ff']);
    var dResult = await dDoc.get();
    await dResult.docs.first.reference.delete();
  }

  Future<void> editProduct({
    required String id,
    required String name,
    required String desc,
    required Map<String, dynamic> specs,
    String? categoryId,
    String? categoryName,
    File? photo,
  }) async {
    var doc = _productCollection.doc(id);
    var result = await doc.get();

    var data = (result.data() as Map<String, dynamic>);
    data['name'] = name;

    if (categoryId != null) {
      data['category_id'] = categoryId;
      data['category_name'] = categoryName;
    }

    if (photo != null) {
      await _storage.refFromURL(data['photo']).delete();
      String photoName = basename(photo.path);

      Reference ref = _storage.ref().child(photoName);
      TaskSnapshot task = await ref.putFile(photo);
      String photoUrl = await task.ref.getDownloadURL();

      data['photo'] = photoUrl;
    }

    await doc.update(data);

    var dDoc = _productDetailCollection
        .orderBy('product_id')
        .startAt([id]).endAt(['$id\uf8ff']);
    var dResult = await dDoc.get();
    var dData = dResult.docs.first.data() as Map<String, dynamic>;

    dData['descriptions'] = desc;
    dData['specifications'] = specs;

    await dResult.docs.first.reference.update(dData);
  }

  Future<void> addProduct({
    required File photo,
    required String name,
    required String categoryId,
    required String categoryName,
    required String desc,
    required Map<String, dynamic> specs,
  }) async {
    String photoName = basename(photo.path);

    Reference ref = _storage.ref().child(photoName);
    TaskSnapshot task = await ref.putFile(photo);
    String photoUrl = await task.ref.getDownloadURL();

    var doc = _productCollection.doc();
    await doc.set({
      'photo': photoUrl,
      'name': name,
      'category_name': categoryName,
      'category_id': categoryId,
      'total_review': 0,
      'total_start': 0,
    });

    var detailDoc = _productDetailCollection.doc();
    await detailDoc.set({
      'product_id': doc.id,
      'descriptions': desc,
      'specifications': specs,
    });
  }

  Future<DetailProductData> getDetail({
    required String id,
  }) async {
    var result = _productDetailCollection
        .orderBy('product_id')
        .startAt([id]).endAt(['$id\uf8ff']);
    var doc = await result.get();
    var data = DetailProductData.fromJson(
        doc.docs.first.data() as Map<String, dynamic>);
    data.id = doc.docs.first.id;

    return data;
  }

  Future<List<ProductData>> getProducts({
    String? category,
    String? query,
  }) async {
    List<ProductData> data = [];
    QuerySnapshot? result;

    if (query != null && category != null) {
      result = await _productCollection
          .orderBy('category_id')
          .startAt([category])
          .endAt(['$category\uf8ff'])
          .get();
    } else {
      if (query != null) {
        result = await _productCollection
            .orderBy('name')
            .startAt([query]).endAt(['$query\uf8ff']).get();
      }

      if (category != null) {
        result = await _productCollection
            .orderBy('category_id')
            .startAt([category]).endAt(['$category\uf8ff']).get();
      }

      if (query == null && category == null) {
        result = await _productCollection.get();
      }
    }

    if (result != null) {
      for (var doc in result.docs) {
        var mData = ProductData.fromJson(doc.data() as Map<String, dynamic>);
        mData.id = doc.id;
        if (query != null && category != null) {
          if (mData.name.toLowerCase().contains(query.toLowerCase())) {
            data.add(mData);
          }
        } else {
          data.add(mData);
        }
      }
    }

    return data;
  }
}
