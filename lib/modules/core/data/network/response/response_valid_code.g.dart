// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_valid_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseValidCode _$ResponseValidCodeFromJson(Map<String, dynamic> json) =>
    ResponseValidCode(
      refreshToken: json['refreshToken'] as String?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$ResponseValidCodeToJson(ResponseValidCode instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };
