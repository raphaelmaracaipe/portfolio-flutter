import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';

class UiAuthPage extends StatelessWidget {
  const UiAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SvgPicture.asset(
            "assets/images/icon_app.svg",
            color: Colors.white,
          ),
          Text("welcome".i18n())
        ],
      ),
    );
  }
}
