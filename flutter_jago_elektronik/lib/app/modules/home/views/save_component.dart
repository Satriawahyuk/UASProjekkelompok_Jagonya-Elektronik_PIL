part of 'home_view.dart';

class SaveComponent extends StatelessWidget {
  SaveComponent({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 24.h),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Obx(() {
              if (controller.finishGetbookmarks.value) {
                return productsWidget();
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
          ],
        ),
      ),
    );
  }

  Widget productsWidget() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: controller.bookmarks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return productWidget(controller.bookmarks[index]);
      },
    );
  }

  Widget productWidget(ProductData product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.detailProduct,
          arguments: {"data": product},
        );
      },
      onLongPress: () {
        if (controller.authFirebase.data != null) {
          if (controller.authFirebase.data!.isAdmin) {
            Get.toNamed(
              Routes.addProduct,
              arguments: {"data": product},
            );
          }
        }
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OnlineImage(
                imageUrl: product.photo,
                height: 0.3.sw,
                width: 0.3.sw,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 12.h),
              TextFormat(
                product.name,
                32.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
