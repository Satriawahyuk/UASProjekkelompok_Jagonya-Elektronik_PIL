import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/data/review.dart';
import 'package:flutter_jago_elektronik/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_jago_elektronik/app/data/bookmark.dart';
import 'package:flutter_jago_elektronik/app/data/product.dart';
import 'package:flutter_jago_elektronik/app/data/category.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/data/model/detail_product_data.dart';

class DetailProductController extends GetxController {
  final authFirebase = Get.find<AuthFirebase>();
  final productFirestore = Get.find<ProductFirestore>();
  final categoryFirestore = Get.find<CategoryFirestore>();
  final bookmarkFirestore = Get.find<BookmarkFirestore>();
  final reviewFirestore = Get.find<ReviewFirestore>();

  ProductData pData = Get.arguments['data'] as ProductData;
  DetailProductData? dProduct;
  int rating = 0;

  RxBool finishGetDetail = false.obs;
  RxBool isBookmark = false.obs;
  RxBool hasReview = false.obs;

  DetailProductController() {
    getDetailProduct();
    checkBookmark();
    checkReview();
  }

  void getDetailProduct() {
    finishGetDetail.value = false;
    productFirestore.getDetail(id: pData.id).then((value) {
      dProduct = value;
      finishGetDetail.value = true;
    });
  }

  void addBookmark() {
    bookmarkFirestore.addBookmark(
      user: authFirebase.currentUser!.uid,
      product: pData.id,
    ).whenComplete(() {
      checkBookmark();
      if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().getBookmarks();
      }
    });
  }

  void addReview() {
    reviewFirestore.addReview(
      user: authFirebase.currentUser!.uid,
      product: pData.id,
      rating: rating,
    ).whenComplete(() {
      checkReview();
      Get.back();
    });
  }

  void deleteBookmark() {
    bookmarkFirestore.deleteBookmark(
      user: authFirebase.currentUser!.uid,
      product: pData.id,
    ).whenComplete(() {
      checkBookmark();
      if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().getBookmarks();
      }
    });
  }

  void checkBookmark() {
    bookmarkFirestore.isBookmark(
      user: authFirebase.currentUser!.uid,
      product: pData.id,
    ).then((value) {
      isBookmark.value = value;
    });
  }

  void checkReview() {
    reviewFirestore.hasReview(
      user: authFirebase.currentUser!.uid,
      product: pData.id,
    ).then((value) {
      hasReview.value = value;
    });
  }
}
