import 'package:flutter/widgets.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class UiContactPages extends StatefulWidget {
  const UiContactPages({super.key});

  @override
  State<StatefulWidget> createState() => _UiContactPages();
}

class _UiContactPages extends State<UiContactPages> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Contact",
      key: Key(
        "UiContactPagesTest",
      ),
    );
  }
}
