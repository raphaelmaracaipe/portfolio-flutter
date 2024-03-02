import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_profile.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository_impl.dart';

import 'profile_repository_test.mocks.dart';

class RestProfileMock extends Mock implements RestProfile {}

@GenerateMocks([
  RestProfileMock,
])
void main() {
  final MockRestProfileMock profileRestMock = MockRestProfileMock();

  test(
    'when send profile to server with success',
    () async {
      when(profileRestMock.requestProfile(any)).thenAnswer((_) async {});

      ProfileRepository profileRepository = ProfileRepositoryImpl(
        restProfile: profileRestMock,
      );

      try {
        await profileRepository.sendProfile(RequestProfile());
        expect(true, true);
      } on Exception catch (_) {
        expect(true, false);
      }
    },
  );

  test(
    'when send profile to server but return error DioException',
    () async {
      when(
        profileRestMock.requestProfile(any),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      ProfileRepository profileRepository = ProfileRepositoryImpl(
        restProfile: profileRestMock,
      );

      try {
        await profileRepository.sendProfile(RequestProfile());
        expect(true, false);
      } on Exception catch (_) {
        expect(true, true);
      }
    },
  );

  test(
    'when send profile to server but return error exception',
    () async {
      when(
        profileRestMock.requestProfile(any),
      ).thenThrow(
        HttpException.putEnum(
          HttpErrorEnum.ERROR_GENERAL,
        ),
      );

      ProfileRepository profileRepository = ProfileRepositoryImpl(
        restProfile: profileRestMock,
      );

      try {
        await profileRepository.sendProfile(RequestProfile());
        expect(true, false);
      } on Exception catch (_) {
        expect(true, true);
      }
    },
  );
}
