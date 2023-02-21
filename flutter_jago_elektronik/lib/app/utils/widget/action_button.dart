part of 'widgets.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color boxColor;
  final Color fontColor;
  final double? fontSize;
  final double? elevation;
  final Size? minimumSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Widget? suffix;
  final Function()? onTap;

  const ActionButton({
    Key? key,
    required this.text,
    required this.boxColor,
    required this.fontColor,
    this.minimumSize,
    this.fontWeight,
    this.elevation,
    this.fontSize,
    this.padding,
    this.onTap,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: boxColor,
        elevation: elevation,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 16.h,
            ),
      ),
      child: (suffix == null)
          ? TextFormat(
              text,
              fontSize ?? 28.sp,
              fontColor: fontColor,
              fontWeight: fontWeight,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                suffix!,
                TextFormat(
                  text,
                  fontSize ?? 28.sp,
                  fontColor: fontColor,
                  fontWeight: fontWeight,
                ),
              ],
            ),
    );
  }
}
