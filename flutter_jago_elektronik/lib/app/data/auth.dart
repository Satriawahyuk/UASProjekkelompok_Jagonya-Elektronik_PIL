import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_jago_elektronik/app/data/user.dart';
import 'package:flutter_jago_elektronik/app/data/model/user_data.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserFirestore _userFirestore = Get.find<UserFirestore>();
  User? currentUser;
  RxInt stateChanged = 0.obs;
  UserData? data;

  AuthFirebase() {
    // Set current user
    currentUser = _firebaseAuth.currentUser;

    // Listen auth state changes
    _firebaseAuth.authStateChanges().listen((event) async {
      currentUser = event;
      await updateUser();
    });
  }

  Future<void> updateUser() async {
    if (currentUser != null) {
      await _userFirestore.getUser(id: currentUser!.uid).then((value) {
        data = UserData.fromJson(value.data() as Map<String, dynamic>);
      });
    }
    stateChanged.value += 1;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String frontName,
    required String endName,
  }) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userFirestore.updateUser(
        id: user.user!.uid,
        frontName: frontName,
        endName: endName,
        email: email,
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
