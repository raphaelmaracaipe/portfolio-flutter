import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_valid_code.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';

import 'uivalid_code_bloc_test.mocks.dart';

class MockUserRepository extends Mock implements UserRepository {}

@GenerateMocks([MockUserRepository])
void main() {
  late UiValidCodeBloc uiValidCodeBloc;
  late MockMockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockMockUserRepository();
    uiValidCodeBloc = UiValidCodeBloc(userRepository: mockUserRepository);
  });

  blocTest<UiValidCodeBloc, UiValidCodeBlocState>(
    'when send state of request code and api return success',
    build: () {
      final ResponseValidCode response = ResponseValidCode(
        accessToken: "AAA",
        refreshToken: "BBB",
      );

      when(
        mockUserRepository.requestValidCode(any),
      ).thenAnswer((_) async => response);

      return uiValidCodeBloc;
    },
    act: (bloc) => bloc.add(SendCodeToValidationEvent(code: "1")),
    expect: () => [
      const UiValidCodeBlocLoading(),
      UiValidCodeBlocLoaded(response: ResponseValidCode())
    ],
  );

  blocTest<UiValidCodeBloc, UiValidCodeBlocState>(
    'when send state of request code and api return error',
    build: () {
      when(mockUserRepository.requestValidCode(any)).thenThrow(
        HttpException.putEnum(
          HttpErrorEnum.USER_SEND_CODE_INVALID,
        ),
      );

      return uiValidCodeBloc;
    },
    act: (bloc) => bloc.add(SendCodeToValidationEvent(code: '1')),
    expect: () => [
      const UiValidCodeBlocLoading(),
      const UiValidCodeBlocError(
        codeError: HttpErrorEnum.USER_SEND_CODE_INVALID,
      )
    ],
  );
}
