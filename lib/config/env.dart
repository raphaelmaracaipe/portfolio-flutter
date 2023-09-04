enum BuildFlavor { producation, development }

BuildEnvironment? get env => _env;
BuildEnvironment? _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;

  BuildEnvironment._init({required this.flavor, required this.baseUrl});

  static void init({required flavor, required baseUrl}) =>
      _env ??= BuildEnvironment._init(
        flavor: flavor,
        baseUrl: baseUrl,
      );
}
