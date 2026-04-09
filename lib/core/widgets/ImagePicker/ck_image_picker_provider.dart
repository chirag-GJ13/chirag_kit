// chirag_kit/core/widgets/ImagePicker/ck_image_picker_provider.dart

import 'dart:io';

import 'package:chirag_kit/core/network/ck_base_provider.dart';
import 'package:chirag_kit/core/widgets/ImagePicker/ck_image_picker_service.dart';

class CKImagePickerProvider extends CKBaseProvider {
  File? _image;

  File? get image => _image;

  bool get hasImage => _image != null;

  Future<void> pickFromCamera() async {
    final file = await CKImagePickerService.fromCamera();
    if (file == null) return;
    _image = file;
    safeNotify();
  }

  Future<void> pickFromGallery() async {
    final file = await CKImagePickerService.fromGallery();
    if (file == null) return;
    _image = file;
    safeNotify();
  }

  void clearImage() {
    _image = null;
    safeNotify();
  }
}
