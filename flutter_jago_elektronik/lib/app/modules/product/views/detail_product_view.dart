import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/modules/product/controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          color: AppColors.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 0.075.sw),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 24.h),
              OnlineImage(
                imageUrl: controller.pData.photo,
                height: 1.sw,
                width: 0.4.sh,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormat(
                    controller.pData.name,
                    36.sp,
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isBookmark.value) {
                        controller.deleteBookmark();
                      } else {
                        controller.addBookmark();
                      }
                    },
                    child: Obx(() {
                      if (controller.isBookmark.value) {
                        return Icon(
                          Icons.bookmark_remove_rounded,
                          size: 48.h,
                          color: AppColors.alertColor,
                        );
                      } else {
                        return Icon(
                          Icons.bookmark_add_rounded,
                          size: 48.h,
                          color: AppColors.greenColor,
                        );
                      }
                    }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBarIndicator(
                    rating: controller.pData.star,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                    ),
                    itemCount: 5,
                    itemSize: 54.w,
                    unratedColor: AppColors.primaryColor.withAlpha(50),
                    direction: Axis.horizontal,
                  ),
                  TextFormat(
                    " | ",
                    32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  TextFormat(
                    "${controller.pData.star}",
                    32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: TextFormat(
                    controller.pData.categoryName,
                    32.sp,
                    fontColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.black87,
                    size: 42.h,
                  ),
                  SizedBox(width: 16.w),
                  TextFormat(
                    "Deskripsi",
                    36.sp,
                    fontColor: Colors.black54,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Obx(() {
                if (controller.finishGetDetail.value) {
                  return Padding(
                    padding: EdgeInsets.only(left: 42.w),
                    child: TextFormat(
                      controller.dProduct!.descriptions,
                      30.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
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
              }),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.black87,
                    size: 42.h,
                  ),
                  SizedBox(width: 16.w),
                  TextFormat(
                    "Spesifikasi",
                    36.sp,
                    fontColor: Colors.black54,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Obx(() {
                if (controller.finishGetDetail.value) {
                  return specWidget();
                } else {
                  return Center(
                    child: SizedBox(
                      height: 0.2.sw,
                      width: 0.2.sw,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
              }),
              SizedBox(height: 24.h),
              reviewWidget(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget specWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: controller.dProduct!.specifications.entries.map<Widget>((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormat(
                  e.key,
                  32.sp,
                  fontColor: Colors.black87,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
                TextFormat(
                  e.value,
                  32.sp,
                  fontColor: Colors.black87,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget reviewWidget() {
    return Column(
      children: [
        TextFormat(
          "Ingin memberikan penilaian tentang produk ini ?",
          30.sp,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.hasReview.value) {
            return TextFormat(
              "Kamu sudah memberikan penilaian",
              30.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            );
          } else {
            return ActionButton(
              text: "Berikan Nilai",
              boxColor: AppColors.greenColor,
              fontColor: Colors.white,
              onTap: () => showReview(),
              minimumSize: Size(
                0.7.sw,
                64.h,
              ),
            );
          }
        }),
      ],
    );
  }

  void showReview() {
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 24.w,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormat(
                "Yuk berikan penilaian kamu",
                32.sp,
              ),
              SizedBox(height: 12.h),
              RatingBar.builder(
                glow: false,
                itemCount: 5,
                itemSize: 64.w,
                direction: Axis.horizontal,
                unratedColor: AppColors.primaryColor.withAlpha(50),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: AppColors.primaryColor,
                ),
                onRatingUpdate: (rating) {
                  controller.rating = rating.toInt();
                },
              ),
              SizedBox(height: 48.h),
              ActionButton(
                text: "Kirim",
                boxColor: AppColors.greenColor,
                fontColor: Colors.white,
                onTap: () => controller.addReview(),
                minimumSize: Size(
                  0.6.sw,
                  64.h,
                ),
              ),
              SizedBox(height: 12.h),
              ActionButton(
                text: "batal",
                boxColor: AppColors.alertColor,
                fontColor: Colors.white,
                onTap: () => Get.back(),
                minimumSize: Size(
                  0.6.sw,
                  64.h,
                ),
              ),
            ],
          ),
        ),
      ),
      useSafeArea: true,
    );
  }
}
