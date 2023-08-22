import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository_impl.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';

import 'route_repository_test.mocks.dart';

class RouteSPMock extends Mock implements RouteSP {}

@GenerateMocks([RouteSPMock])
void main() {
  late MockRouteSPMock routeSPMock;
  late RouteRepository routeRepository;

  setUp(() {
    routeSPMock = MockRouteSPMock();
    routeRepository = RouteRepositoryImpl(routeSP: routeSPMock);
  });

  test('when clean route saved in sp', () async {
    try {
      await routeRepository.clean();
      expect(true, true);
    } on Exception {
      expect(true, false);
    }
  });

  test('when get route saved', () async {
    String route = '/test';
    when(routeSPMock.get()).thenAnswer((_) async => route);
    String getRouteSaved = await routeRepository.get();
    expect(route, getRouteSaved);
  });

  test('when get route saved', () async {
    when(routeSPMock.save(any)).thenAnswer((_) async => true);
    try {
      await routeRepository.save('/test');
      expect(true, true);
    } on Exception {
      expect(true, false);
    }
  });
}
