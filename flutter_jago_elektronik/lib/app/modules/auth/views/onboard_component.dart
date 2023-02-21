part of 'auth_view.dart';

class OnBoardComponent extends StatelessWidget {
  OnBoardComponent({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Stack(
        key: UniqueKey(),
        children: [
          Align(
            alignment: const Alignment(0, -0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                titleText("Jago\nElektronik"),
                SizedBox(height: 24.h),
                TextFormat(
                  "Jelajahi Katalog Kami!",
                  64.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                  fontColor: Colors.white,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: TextFormat(
              "Temukan Informasi yang anda butuhkan hanya dengan beberapa klik",
              30.sp,
              textAlign: TextAlign.start,
              fontColor: Colors.white,
              maxLines: 3,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: ActionButton(
              text: "Explore Now",
              boxColor: AppColors.primaryColor,
              fontColor: AppColors.textColor,
              minimumSize: Size(1.sw, 80.h),
              onTap: () {
                controller.pageNumber.value = 1;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 100.sp,
        fontWeight: FontWeight.w800,
        height: 1,
        letterSpacing: -1,
        color: AppColors.primaryColor,
      ),
    );
  }
}
