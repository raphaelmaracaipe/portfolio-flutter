import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_token.dart';
import 'package:portfolio_flutter/modules/core/data/network/rest_token.dart';
import 'package:portfolio_flutter/modules/core/data/sp/token_sp.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository.dart';
import 'package:portfolio_flutter/modules/core/data/token_interceptor_repository_impl.dart';

import 'token_interceptor_repository_test.mocks.dart';

class RestTokenMock extends Mock implements RestToken {}

class TokenSPMock extends Mock implements TokenSP {}

@GenerateMocks([
  RestTokenMock,
  TokenSPMock,
])
void main() {
  final MockRestTokenMock restTokenMock = MockRestTokenMock();
  final MockTokenSPMock tokenSPMock = MockTokenSPMock();

  test(
    'when make update token and return success',
    () async {
      when(restTokenMock.updateToken(any)).thenAnswer(
        (_) async => ResponseToken(
          accessToken: 'access2',
          refreshToken: 'refresh2',
        ),
      );
      when(tokenSPMock.save(any)).thenAnswer((_) async {});
      when(
        tokenSPMock.get(),
      ).thenAnswer(
        (_) async => ResponseToken(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      TokenInterceptorRepository repository = TokenInterceptorRepositoryImpl(
        restToken: restTokenMock,
        tokenSP: tokenSPMock,
      );

      try {
        final token = await repository.updateToken();
        expect('access2', token.accessToken);
      } on Exception {
        expect(true, false);
      }
    },
  );

  test(
    'when make update token but return error DioException',
    () async {
      when(
        restTokenMock.updateToken(any),
      ).thenThrow(DioException(requestOptions: RequestOptions()));
      when(
        tokenSPMock.get(),
      ).thenAnswer(
        (_) async => ResponseToken(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      TokenInterceptorRepository repository = TokenInterceptorRepositoryImpl(
        restToken: restTokenMock,
        tokenSP: tokenSPMock,
      );

      try {
        await repository.updateToken();
        expect(true, false);
      } on Exception {
        expect(true, true);
      }
    },
  );

  test(
    'when make update token but return error generic',
    () async {
      when(
        restTokenMock.updateToken(any),
      ).thenThrow(
        HttpException.putEnum(
          HttpErrorEnum.ERROR_GENERAL,
        ),
      );
      when(
        tokenSPMock.get(),
      ).thenAnswer(
        (_) async => ResponseToken(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      TokenInterceptorRepository repository = TokenInterceptorRepositoryImpl(
        restToken: restTokenMock,
        tokenSP: tokenSPMock,
      );

      try {
        await repository.updateToken();
        expect(true, false);
      } on Exception {
        expect(true, true);
      }
    },
  );
}
