part of 'home_view.dart';

class HomeComponent extends StatelessWidget {
  HomeComponent({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      child: ListView(
        children: [
          SizedBox(height: 24.h),
          InputField(
            TextEditingController(),
            hint: "Cari semua elektronik",
            suffixIcon: const Icon(Icons.search),
            onSubmit: (query) {
              Get.toNamed(
                Routes.product,
                arguments: {'query': query},
              );
            },
          ),
          SizedBox(height: 12.h),
          titleWidget(
            "Kategori",
            onTap: () {
              Get.toNamed(Routes.addCategory, arguments: {});
            },
          ),
          Obx(() {
            if (controller.finishGetCategories.value) {
              return categoriesWidget();
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
          titleWidget(
            "",
            onTap: () {
              Get.toNamed(Routes.addBanner, arguments: {});
            },
          ),
          Obx(() {
            if (controller.finishGetBanners.value) {
              return bannersWidget();
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
          SizedBox(height: 16.h),
          titleWidget(
            "Mitra Resmi",
            onTap: () {
              Get.toNamed(Routes.addPartner, arguments: {});
            },
          ),
          Obx(() {
            if (controller.finishGetPartners.value) {
              return partnersWidget();
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
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget titleWidget(String title, {required Function onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormat(
            title,
            34.sp,
            fontWeight: FontWeight.w600,
          ),
          GetBuilder<HomeController>(
            id: GetBuilderKeys.authStateKey,
            builder: (controller) {
              if (controller.authFirebase.data != null) {
                if (controller.authFirebase.data!.isAdmin) {
                  return GestureDetector(
                    onTap: () => onTap(),
                    child: Icon(
                      Icons.add,
                      color: AppColors.greenColor,
                      size: 48.h,
                    ),
                  );
                }
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget categoriesWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          controller.categories.length,
          (index) {
            var category = controller.categories[index];
            return GestureDetector(
              onLongPress: () {
                if (controller.authFirebase.data != null) {
                  if (controller.authFirebase.data!.isAdmin) {
                    Get.toNamed(
                      Routes.addCategory,
                      arguments: {'data': category},
                    );
                  }
                }
              },
              onTap: () {
                Get.toNamed(
                  Routes.product,
                  arguments: {'category': category},
                );
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 0.5.sw,
                  maxHeight: 0.3.sh,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Card(
                  color: AppColors.primaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnlineImage(
                        imageUrl: category.photo,
                        height: 0.3.sw,
                        width: 0.3.sw,
                        fit: BoxFit.cover,
                      ),
                      TextFormat(
                        category.name,
                        28.sp,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget partnersWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          controller.partners.length,
          (index) {
            var partner = controller.partners[index];
            return GestureDetector(
              onLongPress: () {
                if (controller.authFirebase.data != null) {
                  if (controller.authFirebase.data!.isAdmin) {
                    Get.toNamed(Routes.addPartner,
                        arguments: {'data': partner});
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: OnlineImage(
                  imageUrl: partner.photo,
                  height: 0.25.sw,
                  width: 0.25.sw,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bannersWidget() {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        reverse: false,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          controller.bannerIndex.value = index;
        },
      ),
      items: List.generate(
        controller.banners.length,
        (index) {
          var banner = controller.banners[index];
          return GestureDetector(
            onLongPress: () {
              if (controller.authFirebase.data != null) {
                if (controller.authFirebase.data!.isAdmin) {
                  Get.toNamed(Routes.addBanner, arguments: {'data': banner});
                }
              }
            },
            child: OnlineImage(
              imageUrl: banner.photo,
              height: 0.3.sh,
              width: 1.sw,
            ),
          );
        },
      ),
    );
  }
}
