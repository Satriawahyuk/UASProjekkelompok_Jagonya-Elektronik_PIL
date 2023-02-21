import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserFirestore {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final _storage = FirebaseStorage.instance;

  Future<void> updateUser({
    required String id,
    required String endName,
    required String frontName,
    required String email,
  }) async {
    await _userCollection.doc(id).set({
      'email': email,
      'isAdmin': false,
      'namaDepan': frontName,
      'namaBelakang': endName,
      'photo': '',
    });
  }

  Future<void> updatePhoto({
    required String id,
    required File photo,
  }) async {
    var result = _userCollection.doc(id);
    String photoName = basename(photo.path);

    Reference ref = _storage.ref().child(photoName);
    TaskSnapshot task = await ref.putFile(photo);
    String photoUrl = await task.ref.getDownloadURL();

    await result.update(
      {'photo': photoUrl},
    );

    result.get().then((value) async {
      var photo = (value.data() as Map<String, dynamic>)['photo'];
      await _storage.refFromURL(photo).delete();
    });
  }

  Future<DocumentSnapshot> getUser({
    required String id,
  }) async {
    return await _userCollection.doc(id).get();
  }
}
