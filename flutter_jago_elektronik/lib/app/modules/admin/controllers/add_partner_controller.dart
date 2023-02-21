import 'dart:io';

import 'package:flutter_jago_elektronik/app/data/partner.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';

class AddPartnerController extends GetxController {
  final partnerFirestore = Get.find<PartnerFirestore>();
  SimpleData? sData = Get.arguments['data'] as SimpleData?;

  final nameInput = TextEditingController();
  XFile? file;

  AddPartnerController() {
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

  void addPartner() {
    openLoadingDialog();
    partnerFirestore
        .addPartner(
      name: nameInput.text,
      photo: File(file!.path),
    )
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void editPartner() {
    openLoadingDialog();
    partnerFirestore
        .editPartner(
            id: sData!.id,
            name: nameInput.text,
            photo: (file == null) ? null : File(file!.path))
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void deletePartner() {
    openLoadingDialog();
    partnerFirestore.deletePartner(id: sData!.id).whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }
}
