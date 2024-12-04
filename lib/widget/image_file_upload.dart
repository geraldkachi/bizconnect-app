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
  String? _fileName;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _fileName = image.name;
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
      _fileName = null;
    });
  }

 void _viewImage() {
  // Open the image in a full-screen dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog when tapping outside
          },
          child: Center(
            heightFactor: 300,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.contain, // Ensure the image is contained within the available space
              ),
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
          onTap: _pickImage,
          child: Container(
            height: _selectedImage == null ? 50 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: _selectedImage != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Expanded(
                        child: Text(
                          _fileName ?? "File selected",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons
                                  .remove_red_eye, // eye icon to be able to view the image
                              color: Colors.grey,
                            ),
                            onPressed: _viewImage,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                            onPressed: _deleteImage,
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
