import 'package:image_picker/image_picker.dart' as picker;
import 'package:permission_handler/permission_handler.dart';

class ImagePicker {
  static Future<picker.XFile?> pickImage(bool isFromGallery) async {
    final PermissionStatus status;
    if (isFromGallery) {
      status = await Permission.mediaLibrary.request();
    } else {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      final imagePicker = picker.ImagePicker();
      return imagePicker.pickImage(
        source: isFromGallery
            ? picker.ImageSource.gallery
            : picker.ImageSource.camera,
      );
    }
    return null;
  }
}
