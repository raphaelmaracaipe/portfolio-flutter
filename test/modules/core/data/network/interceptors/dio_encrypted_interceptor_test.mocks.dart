// Mocks generated by Mockito 5.4.2 from annotations
// in portfolio_flutter/test/modules/core/data/network/interceptors/dio_encrypted_interceptor_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dio/dio.dart' as _i5;
import 'package:dio/src/dio_mixin.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

import 'dio_encrypted_interceptor_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeInterceptorState_0<T> extends _i1.SmartFake
    implements _i2.InterceptorState<T> {
  _FakeInterceptorState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RequestInterceptorHandlerMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequestInterceptorHandlerMock extends _i1.Mock
    implements _i3.RequestInterceptorHandlerMock {
  MockRequestInterceptorHandlerMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.InterceptorState<dynamic>> get future => (super.noSuchMethod(
        Invocation.getter(#future),
        returnValue: _i4.Future<_i2.InterceptorState<dynamic>>.value(
            _FakeInterceptorState_0<dynamic>(
          this,
          Invocation.getter(#future),
        )),
      ) as _i4.Future<_i2.InterceptorState<dynamic>>);
  @override
  bool get isCompleted => (super.noSuchMethod(
        Invocation.getter(#isCompleted),
        returnValue: false,
      ) as bool);
  @override
  void next(_i5.RequestOptions? requestOptions) => super.noSuchMethod(
        Invocation.method(
          #next,
          [requestOptions],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resolve(
    _i5.Response<dynamic>? response, [
    bool? callFollowingResponseInterceptor = false,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #resolve,
          [
            response,
            callFollowingResponseInterceptor,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void reject(
    _i5.DioException? error, [
    bool? callFollowingErrorInterceptor = false,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #reject,
          [
            error,
            callFollowingErrorInterceptor,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ResponseInterceptorHandlerMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockResponseInterceptorHandlerMock extends _i1.Mock
    implements _i3.ResponseInterceptorHandlerMock {
  MockResponseInterceptorHandlerMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.InterceptorState<dynamic>> get future => (super.noSuchMethod(
        Invocation.getter(#future),
        returnValue: _i4.Future<_i2.InterceptorState<dynamic>>.value(
            _FakeInterceptorState_0<dynamic>(
          this,
          Invocation.getter(#future),
        )),
      ) as _i4.Future<_i2.InterceptorState<dynamic>>);
  @override
  bool get isCompleted => (super.noSuchMethod(
        Invocation.getter(#isCompleted),
        returnValue: false,
      ) as bool);
  @override
  void next(_i5.Response<dynamic>? response) => super.noSuchMethod(
        Invocation.method(
          #next,
          [response],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resolve(_i5.Response<dynamic>? response) => super.noSuchMethod(
        Invocation.method(
          #resolve,
          [response],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void reject(
    _i5.DioException? error, [
    bool? callFollowingErrorInterceptor = false,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #reject,
          [
            error,
            callFollowingErrorInterceptor,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [EncryptionDecryptAESMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockEncryptionDecryptAESMock extends _i1.Mock
    implements _i3.EncryptionDecryptAESMock {
  MockEncryptionDecryptAESMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<dynamic> encryptData({
    required String? text,
    required String? key,
    required String? iv,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #encryptData,
          [],
          {
            #text: text,
            #key: key,
            #iv: iv,
          },
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> decryptData({
    required dynamic encrypted,
    required String? key,
    required String? iv,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #decryptData,
          [],
          {
            #encrypted: encrypted,
            #key: key,
            #iv: iv,
          },
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}

/// A class which mocks [KeysMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockKeysMock extends _i1.Mock implements _i3.KeysMock {
  MockKeysMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String generateKey(int? length) => (super.noSuchMethod(
        Invocation.method(
          #generateKey,
          [length],
        ),
        returnValue: '',
      ) as String);
}

/// A class which mocks [KeySPMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockKeySPMock extends _i1.Mock implements _i3.KeySPMock {
  MockKeySPMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> isExistKeyAndIVSaved() => (super.noSuchMethod(
        Invocation.method(
          #isExistKeyAndIVSaved,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> saveKey(String? key) => (super.noSuchMethod(
        Invocation.method(
          #saveKey,
          [key],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> saveSeed(String? seed) => (super.noSuchMethod(
        Invocation.method(
          #saveSeed,
          [seed],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<String> getKey() => (super.noSuchMethod(
        Invocation.method(
          #getKey,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<String> getSeed() => (super.noSuchMethod(
        Invocation.method(
          #getSeed,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [DeviceSPMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeviceSPMock extends _i1.Mock implements _i3.DeviceSPMock {
  MockDeviceSPMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> getDeviceID() => (super.noSuchMethod(
        Invocation.method(
          #getDeviceID,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [BytesMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockBytesMock extends _i1.Mock implements _i3.BytesMock {
  MockBytesMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<int> convertStringToBytes(
    String? input, {
    String? encoding = r'utf-8',
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertStringToBytes,
          [input],
          {#encoding: encoding},
        ),
        returnValue: <int>[],
      ) as List<int>);
  @override
  String convertBytesToString(
    List<int>? bytes, {
    String? encoding = r'utf-8',
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertBytesToString,
          [bytes],
          {#encoding: encoding},
        ),
        returnValue: '',
      ) as String);
}
