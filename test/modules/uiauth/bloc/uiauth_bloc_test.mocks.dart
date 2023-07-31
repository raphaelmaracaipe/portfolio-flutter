// Mocks generated by Mockito 5.4.2 from annotations
// in portfolio_flutter/test/modules/uiauth/bloc/uiauth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:logger/logger.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart'
    as _i5;
import 'package:portfolio_flutter/modules/core/data/network/request/request_user_code.dart'
    as _i6;
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart'
    as _i2;

import 'uiauth_bloc_test.dart' as _i3;

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

class _FakeResponseValidCode_0 extends _i1.SmartFake
    implements _i2.ResponseValidCode {
  _FakeResponseValidCode_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MockCountriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockCountriesRepository extends _i1.Mock
    implements _i3.MockCountriesRepository {
  MockMockCountriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.CountryModel>> readJSON() => (super.noSuchMethod(
        Invocation.method(
          #readJSON,
          [],
        ),
        returnValue:
            _i4.Future<List<_i5.CountryModel>>.value(<_i5.CountryModel>[]),
      ) as _i4.Future<List<_i5.CountryModel>>);
}

/// A class which mocks [MockUserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockUserRepository extends _i1.Mock
    implements _i3.MockUserRepository {
  MockMockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> requestCode(_i6.RequestUserCode? requestUserCode) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestCode,
          [requestUserCode],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.ResponseValidCode> requestValidCode(String? code) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestValidCode,
          [code],
        ),
        returnValue:
            _i4.Future<_i2.ResponseValidCode>.value(_FakeResponseValidCode_0(
          this,
          Invocation.method(
            #requestValidCode,
            [code],
          ),
        )),
      ) as _i4.Future<_i2.ResponseValidCode>);
  @override
  _i4.Future<void> saveRoute(String? typeScreen) => (super.noSuchMethod(
        Invocation.method(
          #saveRoute,
          [typeScreen],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<String> getRouteSaved() => (super.noSuchMethod(
        Invocation.method(
          #getRouteSaved,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<void> cleanRouteSaved() => (super.noSuchMethod(
        Invocation.method(
          #cleanRouteSaved,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [MockLogger].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockLogger extends _i1.Mock implements _i3.MockLogger {
  MockMockLogger() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void v(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #v,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #t,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #d,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #i,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #w,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #e,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void wtf(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #wtf,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #f,
          [message],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void log(
    _i7.Level? level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #log,
          [
            level,
            message,
          ],
          {
            #time: time,
            #error: error,
            #stackTrace: stackTrace,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool isClosed() => (super.noSuchMethod(
        Invocation.method(
          #isClosed,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [MockRestClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockRestClient extends _i1.Mock implements _i3.MockRestClient {
  MockMockRestClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> requestCode(_i6.RequestUserCode? requestUserCode) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestCode,
          [requestUserCode],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.ResponseValidCode> requestValidCode(String? code) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestValidCode,
          [code],
        ),
        returnValue:
            _i4.Future<_i2.ResponseValidCode>.value(_FakeResponseValidCode_0(
          this,
          Invocation.method(
            #requestValidCode,
            [code],
          ),
        )),
      ) as _i4.Future<_i2.ResponseValidCode>);
}
