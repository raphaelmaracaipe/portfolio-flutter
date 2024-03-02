import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/utils/strings.dart';
import 'package:portfolio_flutter/modules/core/utils/strings_impl.dart';

void main() {
  final Strings strings = StringsImpl();

  test('when add data in models in json', () {
    final name = strings.generateRandomString(20);
    final requestProfile = RequestProfile(
      name: name,
      photo: strings.generateRandomString(20),
    );

    final json = requestProfile.toJson();
    expect(name, json['name']);
  });

  test('when add values in map and return to model', () {
    const name = 'test name';
    final Map<String, dynamic> mapProfile = {
      'name': name,
      'photo': 'photo test'
    };

    final modelTransformed = RequestProfile.fromJson(mapProfile);
    expect(name, modelTransformed.name);
  });
}
