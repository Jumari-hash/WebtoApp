import 'dart:io';
import 'package:chaquopy/chaquopy.dart';

class PythonService {
  static Future<String> executeCode(String code) async {
    try {
      if (Platform.isAndroid) {
        final result = await Chaquopy.executeCode(code);
        return result['textOutputOrError'] ?? 'No output';
      } else {
        return 'Python execution is only available on Android devices';
      }
    } catch (e) {
      return 'Error executing code: $e';
    }
  }
  
  static Future<bool> isAvailable() async {
    return Platform.isAndroid;
  }
}
