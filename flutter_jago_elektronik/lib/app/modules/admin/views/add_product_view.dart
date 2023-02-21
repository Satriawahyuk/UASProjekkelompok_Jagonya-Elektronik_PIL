import 'dart:io';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jago_elektronik/app/utils/helper.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: TextFormat(
          "${(controller.pData == null) ? "Tambah" : "Perbarui"} Produk",
          34.sp,
          fontColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  inputPhotoWidget(),
                  SizedBox(height: 24.h),
                  InputField(
                    controller.nameInput,
                    hint: "Nama produk",
                  ),
                  SizedBox(height: 24.h),
                  selectCategory(),
                  SizedBox(height: 24.h),
                  InputField(
                    controller.descInput,
                    hint: "Deskripsi produk",
                    inputType: TextInputType.multiline,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              TextFormat("Spesifikasi Produk", 32.sp),
              SizedBox(height: 12.h),
              specificationsWidget(),
              SizedBox(height: 24.h),
              Column(
                children: [
                  ActionButton(
                    text: (controller.pData == null) ? "Tambahkan" : "Perbarui",
                    fontSize: 32.sp,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    boxColor: AppColors.greenColor,
                    minimumSize: Size(0.9.sw, 80.h),
                    onTap: () {
                      if (controller.pData != null) {
                        controller.editProduct();
                      } else {
                        if (controller.checkInput()) {
                          controller.addProduct();
                        }
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  if (controller.pData != null)
                    ActionButton(
                      text: "Hapus",
                      fontSize: 32.sp,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      boxColor: AppColors.alertColor,
                      minimumSize: Size(0.9.sw, 80.h),
                      onTap: () => controller.deleteProduct(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputPhotoWidget() {
    return GestureDetector(
      onTap: () {
        getImage().then(
          (value) {
            if (value != null) {
              controller.file = value;
              controller.update([GetBuilderKeys.imageWidgetKey]);
            }
          },
        );
      },
      child: Container(
        width: 1.sw,
        height: 0.25.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.subtitleColorText,
            width: 2,
          ),
        ),
        child: GetBuilder<AddProductController>(
          id: GetBuilderKeys.imageWidgetKey,
          builder: (controller) {
            if (controller.file == null) {
              if (controller.pData != null) {
                return OnlineImage(
                  imageUrl: controller.pData!.photo,
                  width: 1.sw,
                  height: 0.25.sh,
                  fit: BoxFit.fitWidth,
                );
              }
              return Icon(
                Icons.add_a_photo,
                size: 0.15.sw,
                color: AppColors.subtitleColorText,
              );
            }
            return Image.file(
              fit: BoxFit.fitWidth,
              File(controller.file!.path),
            );
          },
        ),
      ),
    );
  }

  Widget selectCategory() {
    return Obx(
      () {
        if (controller.finishGetCategory.value) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: GetBuilder<AddProductController>(
              id: GetBuilderKeys.selectWidgetKey,
              builder: (controller) {
                if (controller.categories.isEmpty) {
                  return Center(
                    child: SizedBox(
                      height: 0.2.sw,
                      width: 0.2.sw,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                return DropdownButtonFormField<SimpleData>(
                  isExpanded: true,
                  value: controller.selectCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.subtitleColorText),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                  ),
                  hint: TextFormat(
                    "Pilih kategori",
                    32.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  items:
                      controller.categories.map<DropdownMenuItem<SimpleData>>(
                    (e) {
                      return DropdownMenuItem<SimpleData>(
                        value: e,
                        child: TextFormat(e.name, 32.sp),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    controller.selectCategory = value;
                    controller.update([GetBuilderKeys.selectWidgetKey]);
                  },
                );
              },
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              height: 0.2.sw,
              width: 0.2.sw,
              child: const CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget specificationsWidget() {
    return Column(
      children: [
        Obx(() {
          return ListView(
            shrinkWrap: true,
            children: controller.specifications.entries.map<Widget>((e) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 0.4.sw,
                      child: InputField(
                        TextEditingController(text: e.key),
                        hint: "Judul",
                        onSubmit: (value) {
                          controller.specifications.addAll({value: e.value});
                          controller.specifications.remove(e.key);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 0.4.sw,
                      child: InputField(
                        TextEditingController(text: e.value),
                        hint: "Nilai",
                        onSubmit: (value) {
                          controller.specifications[e.key] = value;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle_rounded, size: 0.03.sh),
                      color: AppColors.alertColor,
                      onPressed: () {
                        controller.specifications.remove(e.key);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
        IconButton(
          icon: Icon(Icons.add_box, size: 0.05.sh),
          color: AppColors.greenColor,
          onPressed: () {
            controller.specifications.addAll({"": ""});
          },
        ),
      ],
    );
  }
}
