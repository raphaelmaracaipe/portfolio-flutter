// ignore_for_file: constant_identifier_names

enum HttpErrorEnum {
  UNKNOWN(0),
  ERROR_GENERAL(1000),
  USER_SEND_CODE_PHONE_NOT_VALID(2000),
  USER_SEND_CODE_INVALID(2001);

  final int code;
  const HttpErrorEnum(this.code);

  static HttpErrorEnum getCode(int code) => HttpErrorEnum.values
      .where(
        (httpError) => httpError.code == code,
      )
      .first;
}
