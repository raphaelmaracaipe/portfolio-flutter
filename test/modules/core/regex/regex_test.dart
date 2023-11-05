import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/regex/regex.dart';
import 'package:portfolio_flutter/modules/core/regex/regex_impl.dart';

import 'regex_test.mocks.dart';

class MethodChannelMock extends Mock implements MethodChannel {}

@GenerateMocks([
  MethodChannelMock,
])
void main() {
  late MockMethodChannelMock methodChannelMock;
  late Regex regex;

  setUp(() {
    methodChannelMock = MockMethodChannelMock();
    regex = RegexImpl(regexChannel: methodChannelMock);

    GetIt.instance.allowReassignment = true;
    GetIt.instance.registerSingleton<MethodChannel>(methodChannelMock);
  });

  test('when you want genereted regex', () async {
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenAnswer((_) async => 'test');

    final regexGenerated = await regex.generateString(regexPattern: '');
    expect(regexGenerated, 'test');
  });

  test('when you want genereted regex but return error', () async {
    when(
      methodChannelMock.invokeMethod(any, any),
    ).thenThrow(PlatformException(code: ''));

    try {
      await regex.generateString(regexPattern: '');
      expect(true, false);
    } on Exception {
      expect(true, true);
    }
  });
}
