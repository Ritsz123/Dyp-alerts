import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  Future<File> pickImage() async {
    final picker = ImagePicker();
    PickedFile tempImage = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (tempImage == null) return null; //image not selected
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: tempImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false),
    );

    if (croppedFile == null)
      return null; //image selected but not cropped so no return

    print('Image Path: ${croppedFile.path}');
    return croppedFile; //image selected and cropped
  }
}
