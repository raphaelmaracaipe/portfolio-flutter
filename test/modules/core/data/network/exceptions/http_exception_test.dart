import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';

void main() {
  test('when send dio excetion without code of error', () {
    try {
      throw HttpException(
        exception: DioException(requestOptions: RequestOptions()),
      );
    } on HttpException catch (e) {
      expect(HttpErrorEnum.UNKNOWN.code, e.code);
    }
  });

  test('when send exception with code should return this code', () {
    try {
      throw HttpException(
        exception: DioException(requestOptions: RequestOptions()),
        errorEnum: HttpErrorEnum.AUTHORIZATION_INVALID,
      );
    } on HttpException catch (e) {
      expect(HttpErrorEnum.AUTHORIZATION_INVALID.code, e.code);
    }
  });

  test('when exception receiver error but without code', () {
    try {
      final Map<String, dynamic> mapToReturn = {'message': 'error'};
      final response = Response(
        requestOptions: RequestOptions(),
        data: mapToReturn,
      );

      throw HttpException(
        exception: DioException(
          requestOptions: RequestOptions(),
          response: response,
        ),
      );
    } on HttpException catch (e) {
      expect(HttpErrorEnum.ERROR_GENERAL.code, e.code);
    }
  });

  test('when exception receiver error but with code USER_NOT_FOUND', () {
    try {
      final Map<String, dynamic> mapToReturn = {
        'message': HttpErrorEnum.USER_NOT_FOUND.code,
      };

      final response = Response(
        requestOptions: RequestOptions(),
        data: mapToReturn,
      );

      throw HttpException(
        exception: DioException(
          requestOptions: RequestOptions(),
          response: response,
        ),
      );
    } on HttpException catch (e) {
      expect(HttpErrorEnum.USER_NOT_FOUND.code, e.code);
    }
  });
}
