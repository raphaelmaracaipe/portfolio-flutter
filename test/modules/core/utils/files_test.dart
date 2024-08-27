import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/utils/files.dart';
import 'package:portfolio_flutter/modules/core/utils/files_impl.dart';

import 'files_test.mocks.dart';

class FileMock extends Mock implements File {}

@GenerateMocks([
  FileMock,
])
void main() {
  late MockFileMock fileMock;
  final Files files = FilesImpl();

  setUp(() {
    fileMock = MockFileMock();
  });

  test('when get file and convert to base64', () async {
    final fileBytes = Uint8List.fromList(utf8.encode('conteúdo de teste'));
    when(fileMock.readAsBytes()).thenAnswer((_) async => fileBytes);

    final result = await files.fileToBase64(fileMock);

    expect(result, isNot(equals("")));
  });
}
