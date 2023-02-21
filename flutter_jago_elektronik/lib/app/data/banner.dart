import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BannerFirestore {
  final CollectionReference _bannerCollection =
      FirebaseFirestore.instance.collection('banners');
  final _storage = FirebaseStorage.instance;

  Future<void> deleteBanner({required String id}) async {
    var result = _bannerCollection.doc(id);

    await result.get().then((value) async {
      var photo = (value.data() as Map<String, dynamic>)['photo'];
      await _storage.refFromURL(photo).delete();
    });

    await result.delete();
  }

  Future<void> editBanner({
    required String id,
    required String name,
    File? photo,
  }) async {
    var doc = _bannerCollection.doc(id);
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

  Future<void> addBanner({
    required File photo,
    required String name,
  }) async {
    String photoName = basename(photo.path);

    Reference ref = _storage.ref().child(photoName);
    TaskSnapshot task = await ref.putFile(photo);
    String photoUrl = await task.ref.getDownloadURL();

    var doc = _bannerCollection.doc();
    await doc.set({
      'photo': photoUrl,
      'name': name,
    });
  }

  Future<List<SimpleData>> getBanners() async {
    List<SimpleData> data = [];
    var result = await _bannerCollection.get();

    for (var doc in result.docs) {
      var mData = SimpleData.fromJson(doc.data() as Map<String, dynamic>);
      mData.id = doc.id;
      data.add(mData);
    }

    return data;
  }
}
