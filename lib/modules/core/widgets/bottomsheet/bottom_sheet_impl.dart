import 'package:flutter/material.dart';
import 'package:portfolio_flutter/config/app_fonts.dart';
import 'package:portfolio_flutter/modules/core/widgets/bottomsheet/bottom_sheet.dart';

class BottomsheetImpl extends Bottomsheet {
  @override
  void show({
    required BuildContext context,
    required String title,
    required String text,
    required String btnText,
    required Function onBtnClick,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return SizedBox(
          key: const Key('bottomSheetContainer'),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                height: 4,
                width: 100,
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontFamily: AppFonts.openSans,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextButton(
                  key: const Key('bottomSheetClickButton'),
                  onPressed: () {
                    onBtnClick();
                  },
                  child: Text(
                    btnText,
                    style: const TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
