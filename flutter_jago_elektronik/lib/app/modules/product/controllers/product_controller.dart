import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:get/get.dart';
import 'package:flutter_jago_elektronik/app/data/product.dart';

class ProductController extends GetxController {
  final authFirebase = Get.find<AuthFirebase>();
  final productFirestore = Get.find<ProductFirestore>();

  final queryInput = TextEditingController();

  SimpleData? category = Get.arguments['category'] as SimpleData?;
  String? query = Get.arguments['query'] as String?;

  List<ProductData> products = [];
  RxBool finishGetProducts = false.obs;

  ProductController() {
    if (query != null) {
      queryInput.text = query!;
    }
    searchProduct();
  }

  void searchProduct() {
    finishGetProducts.value = false;
    productFirestore.getProducts(
      category: (category != null) ? category!.id : null,
      query: (queryInput.text.isEmpty) ? null : queryInput.text,
    ).then((value) {
      products.clear();
      products.addAll(value);
      finishGetProducts.value = true;
    });
  }
}
