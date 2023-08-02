import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_event.dart';
import 'package:portfolio_flutter/modules/uisplash/bloc/uisplash_bloc_state.dart';

import 'uisplash_bloc_test.mocks.dart';

class RouteRepositoryMock extends Mock implements RouteRepository {}

@GenerateMocks([RouteRepositoryMock])
void main() {
  late UiSplashBloc uiSplashBloc;
  late MockRouteRepositoryMock routeRepositoryMock;

  setUp(() {
    routeRepositoryMock = MockRouteRepositoryMock();
    uiSplashBloc = UiSplashBloc(routeRepository: routeRepositoryMock);
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
}
