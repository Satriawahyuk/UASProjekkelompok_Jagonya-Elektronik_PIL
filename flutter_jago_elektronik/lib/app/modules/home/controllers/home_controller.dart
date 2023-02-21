import 'dart:io';
import 'package:flutter_jago_elektronik/app/data/banner.dart';
import 'package:flutter_jago_elektronik/app/data/bookmark.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:flutter_jago_elektronik/app/data/partner.dart';
import 'package:flutter_jago_elektronik/app/data/user.dart';
import 'package:get/get.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jago_elektronik/app/data/category.dart';

class HomeController extends GetxController {
  final authFirebase = Get.find<AuthFirebase>();
  final userFirestore = Get.find<UserFirestore>();
  final categoryFirestore = Get.find<CategoryFirestore>();
  final partnerFirestore = Get.find<PartnerFirestore>();
  final bannerFirestore = Get.find<BannerFirestore>();
  final bookmarkFirestore = Get.find<BookmarkFirestore>();

  // Variable
  RxInt index = 0.obs;
  RxInt bannerIndex = 0.obs;
  RxBool finishGetCategories = false.obs;
  RxBool finishGetbookmarks = false.obs;
  RxBool finishGetPartners = false.obs;
  RxBool finishGetBanners = false.obs;

  List<SimpleData> categories = [];
  List<SimpleData> partners = [];
  List<SimpleData> banners = [];
  List<ProductData> bookmarks = [];

  HomeController() {
    getCategories();
    getBookmarks();
    getPartners();
    getBanners();
  }

  void signOut() {
    authFirebase.signOut();
    Get.offAllNamed(Routes.auth);
  }

  Future<void> updatePhotoProfile(XFile photoFile) async {
    userFirestore
        .updatePhoto(
            id: authFirebase.currentUser!.uid, photo: File(photoFile.path))
        .whenComplete(
      () {
        authFirebase.updateUser();
      },
    );
  }

  void getCategories() {
    finishGetCategories.value = false;
    categoryFirestore.getCategories().then((value) {
      categories.clear();
      categories.addAll(value);
      finishGetCategories.value = true;
    });
  }

  void getPartners() {
    finishGetPartners.value = false;
    partnerFirestore.getPartners().then((value) {
      partners.clear();
      partners.addAll(value);
      finishGetPartners.value = true;
    });
  }

  void getBanners() {
    finishGetBanners.value = false;
    bannerFirestore.getBanners().then((value) {
      banners.clear();
      banners.addAll(value);
      finishGetBanners.value = true;
    });
  }

  void getBookmarks() {
    finishGetbookmarks.value = false;
    bookmarkFirestore.getBookmarks(user: authFirebase.currentUser!.uid).then((value) {
      bookmarks.clear();
      bookmarks.addAll(value);
      finishGetbookmarks.value = true;
    });
  }

  @override
  void onInit() {
    ever(authFirebase.stateChanged, (value) {
      update([GetBuilderKeys.authStateKey]);
    });
    super.onInit();
  }
}
