import 'package:flutter_jago_elektronik/app/data/banner.dart';
import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/data/bookmark.dart';
import 'package:flutter_jago_elektronik/app/data/category.dart';
import 'package:flutter_jago_elektronik/app/data/partner.dart';
import 'package:flutter_jago_elektronik/app/data/product.dart';
import 'package:flutter_jago_elektronik/app/data/review.dart';
import 'package:flutter_jago_elektronik/app/data/user.dart';
import 'package:get/get.dart';

// =========================
// Setup depedency injection 
// =========================

void setupInjector() {
  // Inject User Firestore
  Get.put(
    UserFirestore(),
    permanent: true,
  );

  // Inject Review Firestore
  Get.put(
    ReviewFirestore(),
    permanent: true,
  );

  // Inject Bookmark Firestore
  Get.put(
    BookmarkFirestore(),
    permanent: true,
  );

  // Inject Banner Firestore
  Get.put(
    ProductFirestore(),
    permanent: true,
  );

  // Inject Banner Firestore
  Get.put(
    BannerFirestore(),
    permanent: true,
  );

  // Inject Category Firestore
  Get.put(
    CategoryFirestore(),
    permanent: true,
  );

  // Inject Partner Firestore
  Get.put(
    PartnerFirestore(),
    permanent: true,
  );

  // Inject Auth Firebase
  Get.put(
    AuthFirebase(),
    permanent: true,
  );
}
