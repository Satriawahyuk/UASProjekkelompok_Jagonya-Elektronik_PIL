part of 'auth_view.dart';

class RegisterComponent extends StatelessWidget {
  RegisterComponent({super.key});
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
                "Daftar",
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
                controller.frontNameInput,
                hint: "Nama Depan",
                inputType: TextInputType.name,
              ),
              SizedBox(height: 24.h),
              InputField(
                controller.endNameInput,
                hint: "Nama Belakang",
                inputType: TextInputType.name,
              ),
              SizedBox(height: 24.h),
              InputField(
                controller.passwordInput,
                hint: "Password",
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 24.h),
              InputField(
                controller.confirmPasswordInput,
                hint: "Konfirmasi Password",
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 24.h),
              ActionButton(
                text: "Daftar",
                boxColor: AppColors.primaryColor,
                fontColor: AppColors.textColor,
                minimumSize: Size(1.sw, 80.h),
                onTap: () {
                  if (controller.checkSignUpInput()) {
                    openLoadingDialog();
                    controller.signUpUser();
                  }
                },
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormat(
                    "Sudah punya akun? ",
                    28.sp,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.darkColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pageNumber.value = 1;
                    },
                    child: TextFormat(
                      "Login",
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
