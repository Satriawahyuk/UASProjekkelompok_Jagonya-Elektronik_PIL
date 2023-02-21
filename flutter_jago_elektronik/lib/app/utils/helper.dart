import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  return await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
}
