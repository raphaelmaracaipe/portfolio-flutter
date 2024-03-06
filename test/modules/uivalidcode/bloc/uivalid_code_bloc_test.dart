import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/enums/http_error_enum.dart';
import 'package:portfolio_flutter/modules/core/data/network/exceptions/http_exception.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/user_repository.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_event.dart';
import 'package:portfolio_flutter/modules/uivalidcode/bloc/uivalid_code_bloc_state.dart';

import 'uivalid_code_bloc_test.mocks.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockRouteRepository extends Mock implements RouteRepository {}

@GenerateMocks([
  MockUserRepository,
  MockRouteRepository,
])
void main() {
  late UiValidCodeBloc uiValidCodeBloc;
  late MockMockUserRepository mockUserRepository;
  late MockMockRouteRepository mockRouteRepository;

  setUp(() {
    mockUserRepository = MockMockUserRepository();
    mockRouteRepository = MockMockRouteRepository();

    uiValidCodeBloc = UiValidCodeBloc(
      userRepository: mockUserRepository,
      routeRepository: mockRouteRepository,
    );
  });

  blocTest<UiValidCodeBloc, UiValidCodeBlocState>(
    'when send state of request code and api return success',
    build: () {
      when(
        mockUserRepository.requestValidCode(any),
      ).thenAnswer((_) async => {});

      return uiValidCodeBloc;
    },
    act: (bloc) => bloc.add(SendCodeToValidationEvent(code: "1")),
    expect: () => [
      const UiValidCodeBlocLoading(),
      const UiValidCodeBlocLoaded(),
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

  blocTest(
    'when clean route saved',
    build: () {
      when(mockRouteRepository.clean()).thenAnswer((_) async {});
      return uiValidCodeBloc;
    },
    act: (bloc) => bloc.add(CleanRouteSavedEvent()),
    expect: () => [
      const UiValidCodeBlocLoading(),
      const UiValidCodeBlocCleanRoute(),
    ],
  );
}
