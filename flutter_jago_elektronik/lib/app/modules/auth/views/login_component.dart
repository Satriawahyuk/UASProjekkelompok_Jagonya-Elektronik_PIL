part of 'auth_view.dart';

class LoginComponent extends StatelessWidget {
  LoginComponent({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: UniqueKey(),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 32.h,
          horizontal: 32.w,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormat(
                "Login",
                48.sp,
                fontWeight: FontWeight.w700,
                fontColor: AppColors.darkColor,
              ),
              SizedBox(height: 48.h),
              InputField(
                controller.emailInput,
                hint: "Email",
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              InputField(
                controller.passwordInput,
                hint: "Password",
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 64.h),
              ActionButton(
                text: "Login",
                boxColor: AppColors.primaryColor,
                fontColor: AppColors.textColor,
                minimumSize: Size(1.sw, 80.h),
                onTap: () {
                  if (controller.checkSignInInput()) {
                    openLoadingDialog();
                    controller.signInUser();
                  }
                },
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormat(
                    "Belum punya akun? ",
                    28.sp,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.darkColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pageNumber.value = 2;
                    },
                    child: TextFormat(
                      "Daftar",
                      28.sp,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
