import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/hand_shake_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/security/keys_impl.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';

import 'uisplash_bloc_test.mocks.dart';

class RouteRepositoryMock extends Mock implements RouteRepository {}

class HandShakeRepositoryMock extends Mock implements HandShakeRepository {}

@GenerateMocks([
  RouteRepositoryMock,
  HandShakeRepositoryMock,
])
void main() {
  late UiSplashBloc uiSplashBloc;
  late MockRouteRepositoryMock routeRepositoryMock;
  late MockHandShakeRepositoryMock handShakeRepositoryMock;

  setUp(() {
    routeRepositoryMock = MockRouteRepositoryMock();
    handShakeRepositoryMock = MockHandShakeRepositoryMock();

    uiSplashBloc = UiSplashBloc(
      key: KeysImpl(),
      routeRepository: routeRepositoryMock,
      handShakeRepository: handShakeRepositoryMock,
    );
  });

  blocTest<UiSplashBloc, UiSplashBlocState>(
    'when get route saved but return value empty',
    build: () {
      when(routeRepositoryMock.get()).thenAnswer((_) async => '');
      return uiSplashBloc;
    },
    act: (bloc) => bloc.add(GetRouteSaved()),
    expect: () => [
      const UiSplashBlocRoute(routeName: ''),
    ],
  );

  blocTest<UiSplashBloc, UiSplashBlocState>(
    'when get route saved but return value not empty',
    build: () {
      when(routeRepositoryMock.get()).thenAnswer((_) async => '/test');
      return uiSplashBloc;
    },
    act: (bloc) => bloc.add(GetRouteSaved()),
    expect: () => [
      const UiSplashBlocRoute(routeName: '/test'),
    ],
  );

  blocTest<UiSplashBloc, UiSplashBlocState>(
    'when send code to server',
    build: () {
      when(handShakeRepositoryMock.send()).thenAnswer((_) async {});
      return uiSplashBloc;
    },
    act: (bloc) => bloc.add(SendCodeToServer()),
    expect: () => [
      const UiSplashBlocFinishHandShake(),
    ],
  );

  blocTest<UiSplashBloc, UiSplashBlocState>(
    'when send code to server but return error',
    build: () {
      when(handShakeRepositoryMock.send()).thenThrow(Exception("error"));
      return uiSplashBloc;
    },
    act: (bloc) => bloc.add(SendCodeToServer()),
    expect: () => [
      const UiSplashBlocHandShakeError(),
    ],
  );

}
