abstract class Bytes {
  List<int> convertStringToBytes(String input, {String encoding = 'utf-8'});

  String convertBytesToString(List<int> bytes, {String encoding = 'utf-8'});
}
