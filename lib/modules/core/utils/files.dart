import 'dart:io';

abstract class Files {
  Future<String> fileToBase64(File file);
}
