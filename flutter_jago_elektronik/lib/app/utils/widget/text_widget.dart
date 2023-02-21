part of 'widgets.dart';

class TextFormat extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final int? maxLines;

  const TextFormat(
    this.text,
    this.fontSize, {Key? key, 
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w500,
    this.fontColor = Colors.black,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }
}
