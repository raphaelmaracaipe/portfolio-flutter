import 'package:flutter/material.dart';

class UiProfilePage extends StatelessWidget {
  const UiProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text(
        "profile",
        key: Key("uiProfileContainer"),
      ),
    );
  }
}
