import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> loadFile() async {
  try {
    await dotenv.load(fileName: '.env');
    debugPrint("Loaded env variables");
  } catch (e) {
    debugPrint("Failed to load env variables: ${e.toString()}");
  }
}
