import 'dart:io';
import 'package:flutter_jago_elektronik/app/data/category.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:flutter_jago_elektronik/app/data/product.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';

class AddProductController extends GetxController {
  final productFirestore = Get.find<ProductFirestore>();
  final categoryFirestore = Get.find<CategoryFirestore>();
  ProductData? pData = Get.arguments['data'] as ProductData?;

  XFile? file;
  SimpleData? selectCategory;
  RxMap<String, String> specifications = {"fitur": ""}.obs;
  final nameInput = TextEditingController();
  final descInput = TextEditingController();

  List<SimpleData> categories = [];
  RxBool finishGetCategory = false.obs;

  AddProductController() {
    if (pData != null) {
      nameInput.text = pData!.name;
      getProduct();
    }
    getCategory();
  }

  bool checkInput() {
    if (file == null) {
      openErrorDialog("Photo cannot empty");
      return false;
    }
    if (nameInput.text.isEmpty) {
      openErrorDialog("Name cannot empty");
      return false;
    }

    if (selectCategory == null) {
      openErrorDialog("Select category cannot empty");
      return false;
    }

    if (nameInput.text.isEmpty) {
      openErrorDialog("Descriptions cannot empty");
      return false;
    }

    return true;
  }

  void addProduct() {
    openLoadingDialog();
    productFirestore
        .addProduct(
      name: nameInput.text,
      photo: File(file!.path),
      categoryId: selectCategory!.id,
      categoryName: selectCategory!.name,
      desc: descInput.text,
      specs: specifications,
    )
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void editProduct() {
    openLoadingDialog();
    productFirestore
        .editProduct(
      id: pData!.id,
      name: nameInput.text,
      desc: descInput.text,
      specs: specifications,
      categoryId: (selectCategory != null) ? selectCategory!.id : null,
      categoryName: (selectCategory != null) ? selectCategory!.name : null,
      photo: (file == null) ? null : File(file!.path),
    ).whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void deleteProduct() {
    openLoadingDialog();
    productFirestore.deleteProduct(id: pData!.id).whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void getProduct() {
    productFirestore.getDetail(id: pData!.id).then((value) {
      descInput.text = value.descriptions;
      specifications.remove("fitur");
      value.specifications.forEach(
        (key, value) {
          specifications.addAll({key: value});
        },
      );
      update([GetBuilderKeys.selectWidgetKey]);
    });
  }

  void getCategory() {
    finishGetCategory.value = false;
    categoryFirestore.getCategories().then(
      (value) {
        categories.clear();
        categories.addAll(value);
        finishGetCategory.value = true;
        update([GetBuilderKeys.selectWidgetKey]);
      },
    );
  }
}
