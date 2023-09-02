import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UiProfilePage extends StatelessWidget {
  const UiProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text(
        "profile1",
        key: Key("uiProfileContainer"),
      ),
    );
  }
}
