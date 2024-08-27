import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio_flutter/modules/core/utils/images.dart';

class ImagesImpl extends Images {
  @override
  Image convertBase64ToImage(String base64) {
    final stringClean = base64.replaceAll('\n', '');
    final bytesImage = const Base64Decoder().convert(stringClean);
    return Image.memory(bytesImage);
  }
}
