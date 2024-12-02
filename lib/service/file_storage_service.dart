import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorageService {
  Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Directory directory = Directory('');

    if (Platform.isAndroid) {
      // Redirects to the android download folder
      directory = Directory('/storage/emulated/0/Download');
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  

  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }
}
