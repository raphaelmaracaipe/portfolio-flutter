import 'package:flutter/material.dart';

abstract class Bottomsheet {
  void show({
    required BuildContext context,
    required String title,
    required String text,
    required String btnText,
    required Function onBtnClick,
    enableDrag = true,
  });
}
