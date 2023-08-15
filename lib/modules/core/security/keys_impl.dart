import 'dart:math';

import 'keys.dart';

class KeysImpl extends Keys {
  @override
  String generateKey(int length) {
    const normal = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const special = '!@#\$%^&*()_-+={}[]|:;"\'<>,.?/~`';
    const number = '0123456789';
    const allChars = normal + special + number;

    return List.generate(
      length, (index) => allChars[Random().nextInt(allChars.length)]).join();
  }
}
