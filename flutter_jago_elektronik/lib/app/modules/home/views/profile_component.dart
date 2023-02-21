part of 'home_view.dart';

class ProfileComponent extends StatelessWidget {
  ProfileComponent({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileWidget(),
          ActionButton(
            text: "Logout",
            boxColor: AppColors.alertColor,
            fontColor: Colors.white,
            minimumSize: Size(0.9.sw, 80.h),
            onTap: () => controller.signOut(),
          ),
        ],
      ),
    );
  }

  Widget profileWidget() {
    return GetBuilder<HomeController>(
      id: GetBuilderKeys.authStateKey,
      builder: (controller) {
        var user = controller.authFirebase.data;
        if (user != null) {
          return Row(
            children: [
              photoWidget(),
              SizedBox(width: 24.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormat(
                    "${user.namaDepan} ${user.namaBelakang}",
                    34.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                  ),
                  TextFormat(
                    user.email,
                    30.sp,
                    textAlign: TextAlign.start,
                    fontColor: AppColors.inputBackgroundColor.withOpacity(0.5),
                  ),
                ],
              )
            ],
          );
        }

        return Center(
          child: SizedBox(
            height: 120.h,
            width: 120.h,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget photoWidget() {
    return GestureDetector(
      onTap: () {
        getImage().then(
          (value) {
            if (value != null) {
              controller.updatePhotoProfile(value);
            }
          },
        );
      },
      child: GetBuilder<HomeController>(
        id: GetBuilderKeys.authStateKey,
        builder: (controller) {
          var user = controller.authFirebase.data;

          if (user!.photo.isEmpty) {
            return Icon(
              Icons.photo_camera_front_rounded,
              size: 120.h,
              color: AppColors.inputBackgroundColor.withOpacity(0.8),
            );
          } else {
            return OnlineImage(
              imageUrl: user.photo,
              fit: BoxFit.fitWidth,
              width: 120.h,
              height: 120.h,
            );
          }
        },
      ),
    );
  }
}
