part of 'widgets.dart';

class OnlineImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double? borderRadius;
  final BoxFit? fit;

  const OnlineImage(
      {Key? key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.borderRadius,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder: ((context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: SizedBox(
              height: ((height < width) ? height : width) / 2,
              width: ((height < width) ? height : width) / 2,
              child: const CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }
}
