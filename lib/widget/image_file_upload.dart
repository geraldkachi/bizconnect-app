import 'dart:io';

import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadField extends StatefulWidget {
  final String labelText;
  final String hintText;

  const ImageUploadField({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            color: black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 7),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: grey100,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedImage != null
                    ? Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _selectedImage!,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Image selected",
                            style: TextStyle(
                              fontSize: 14,
                              color: black,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        widget.hintText,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: grey400,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                const Icon(
                  Icons.upload_file,
                  color: grey400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
