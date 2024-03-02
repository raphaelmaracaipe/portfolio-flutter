import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_token.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

void main() {
  final Strings strings = StringsImpl();

  test('when add data in models and transform to json', () {
    final refresh = strings.generateRandomString(10);
    final requestToken = RequestToken(refresh: refresh);

    final json = requestToken.toJson();
    expect(refresh, json['refresh']);
  });

  test('when received datas in json after transform to model', () {
    const refresh = "test in refresh";
    final json = {
      'refresh': refresh,
    };

    final jsonTransformed = RequestToken.fromJson(json);
    expect(refresh, jsonTransformed.refresh);
  });
}
