import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  static Future<void> show({
    required BuildContext context,
    required Size size,
    required Function(ImageSource) onImageSelected,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        color: StylesApp.secondaryColor,
        width: size.width,
        height: size.height * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _pickImageSourceButton(
              context,
              size,
              Icons.camera_alt,
              'Cámara',
              onImageSelected,
            ),
            _pickImageSourceButton(
              context,
              size,
              Icons.photo_library,
              'Galería',
              onImageSelected,
            ),
          ],
        ),
      ),
    );
  }

  static _pickImageSourceButton(
    BuildContext context,
    Size size,
    IconData icon,
    String text,
    Function(ImageSource) onImageSelected,
  ) => InkWell(
    onTap: () => _pickingImageSource(context, icon, onImageSelected),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.width * 0.09,
      ),
      decoration: BoxDecoration(
        color: StylesApp.tertiaryColor,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: size.width * 0.1, color: StylesApp.primaryColor),
          SizedBox(height: size.height * 0.01),
          Text(text),
        ],
      ),
    ),
  );

  static _pickingImageSource(
    BuildContext context,
    IconData icon,
    Function(ImageSource) onImageSelected,
  ) {
    Navigator.pop(context);
    onImageSelected(
      icon == Icons.camera_alt ? ImageSource.camera : ImageSource.gallery,
    );
  }
}
