abstract class RouteRepository {
  Future<void> save(String typeScreen);

  Future<String> get();

  Future<void> clean();
}
