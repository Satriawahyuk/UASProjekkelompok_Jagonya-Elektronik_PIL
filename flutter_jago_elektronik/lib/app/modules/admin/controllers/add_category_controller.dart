import 'dart:io';

import 'package:flutter_jago_elektronik/app/data/category.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';

class AddCategoryController extends GetxController {
  final categoryFirestore = Get.find<CategoryFirestore>();
  SimpleData? sData = Get.arguments['data'] as SimpleData?;

  final nameInput = TextEditingController();
  XFile? file;

  AddCategoryController() {
    if (sData != null) {
      nameInput.text = sData!.name;
    }
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

    return true;
  }

  void addCategory() {
    openLoadingDialog();
    categoryFirestore
        .addCategory(
      name: nameInput.text,
      photo: File(file!.path),
    )
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void editCategory() {
    openLoadingDialog();
    categoryFirestore
        .editCategory(
            id: sData!.id,
            name: nameInput.text,
            photo: (file == null) ? null : File(file!.path))
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void deleteCategory() {
    openLoadingDialog();
    categoryFirestore.deleteCategory(id: sData!.id).whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }
}
