import 'dart:convert';
import 'dart:io';

import 'package:portfolio_flutter/modules/core/utils/files.dart';

class FilesImpl extends Files {
  @override
  Future<String> fileToBase64(File file) async {
    final fileBytes = await file.readAsBytes();
    return base64Encode(fileBytes);
  }
}
