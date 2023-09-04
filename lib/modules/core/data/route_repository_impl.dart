import 'package:injectable/injectable.dart';
import 'package:portfolio_flutter/modules/core/data/sp/route_sp.dart';

import 'route_repository.dart';

class RouteRepositoryImpl extends RouteRepository {
  final RouteSP routeSP;
  RouteRepositoryImpl({required this.routeSP});

  @override
  Future<void> clean() async {
    await routeSP.clean();
  }

  @override
  Future<String> get() async => await routeSP.get();

  @override
  Future<void> save(String typeScreen) async {
    await routeSP.save(typeScreen);
  }
}
