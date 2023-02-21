import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CategoryFirestore {
  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final _storage = FirebaseStorage.instance;

  Future<void> deleteCategory({required String id}) async {
    var result = _categoryCollection.doc(id);

    await result.get().then((value) async {
      var photo = (value.data() as Map<String, dynamic>)['photo'];
      await _storage.refFromURL(photo).delete();
    });

    await result.delete();
  }

  Future<void> editCategory({
    required String id,
    required String name,
    File? photo,
  }) async {
    var doc = _categoryCollection.doc(id);
    var result = await doc.get();

    var data = (result.data() as Map<String, dynamic>);
    data['name'] = name;

    if (photo != null) {
      await _storage.refFromURL(data['photo']).delete();
      String photoName = basename(photo.path);

      Reference ref = _storage.ref().child(photoName);
      TaskSnapshot task = await ref.putFile(photo);
      String photoUrl = await task.ref.getDownloadURL();

      data['photo'] = photoUrl;
    }

    await doc.update(data);
  }

  Future<void> addCategory({
    required File photo,
    required String name,
  }) async {
    String photoName = basename(photo.path);

    Reference ref = _storage.ref().child(photoName);
    TaskSnapshot task = await ref.putFile(photo);
    String photoUrl = await task.ref.getDownloadURL();

    var doc = _categoryCollection.doc();
    await doc.set({
      'photo': photoUrl,
      'name': name,
    });
  }

  Future<List<SimpleData>> getCategories() async {
    List<SimpleData> data = [];
    var result = await _categoryCollection.get();

    for (var doc in result.docs) {
      var mData = SimpleData.fromJson(doc.data() as Map<String, dynamic>);
      mData.id = doc.id;
      data.add(mData);
    }

    return data;
  }
}
