import 'package:dio/dio.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';

class HttpException implements Exception {
  int code = 0;

  HttpException({
    DioException? exception,
    HttpErrorEnum errorEnum = HttpErrorEnum.UNKNOWN,
  }) {
    if(errorEnum != HttpErrorEnum.UNKNOWN){
      code = errorEnum.code;
    } else if (exception?.response == null) {
      code = 0;
    } else {
      final Map<String, dynamic> dataError = exception?.response?.data;
      code = dataError["message"];
    }
  }

  HttpException.putEnum(HttpErrorEnum httpErrorEnum) {
    code = httpErrorEnum.code;
  }

  HttpErrorEnum get enumError {
    return HttpErrorEnum.getCode(code);
  }
}
