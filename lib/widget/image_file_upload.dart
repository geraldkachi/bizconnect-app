import 'dart:io';

import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUploadField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final SetupBusinessProfileViewModel setupProfileWatch;

  const ImageUploadField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.setupProfileWatch,
  });

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  
  void _viewImage(File? file) {
    if (file == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 7),
        GestureDetector(
          onTap: widget.setupProfileWatch.pickImage,
          child: Container(
            height: widget.setupProfileWatch.selectedImage == null ? 50 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: widget.setupProfileWatch.selectedImage != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          widget.setupProfileWatch.selectedImage!,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.setupProfileWatch.fileName ?? "File selected",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons
                                  .crop, // crop icon to be able to crop the image
                              color: Colors.grey,
                            ),
                            onPressed: widget.setupProfileWatch.cropImage,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons
                                  .remove_red_eye, // eye icon to be able to view the image
                              color: Colors.grey,
                            ),
                            onPressed:() => _viewImage(widget.setupProfileWatch.selectedImage),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                            onPressed: widget.setupProfileWatch.deleteImage,
                          ),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(''),
                      Text(
                        widget.hintText,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: red,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                     Transform.rotate(
                    angle: 3.14159, // Rotate 180 degrees (π radians)
                    child: const Icon(
                      Icons.file_download_sharp,
                      color: red,
                      size: 20,
                    ),
                  ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
