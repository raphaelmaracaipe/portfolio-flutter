import 'package:flutter/services.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';

class FormattedPhone extends TextInputFormatter {
  late final CountryModel? _countryModel;
  String _mask = "";

  FormattedPhone({
    required CountryModel? countryModel,
  }) {
    _countryModel = countryModel;
    if (_countryModel != null) {
      _mask = _countryModel?.mask ?? "";
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String textNew = newValue.text;
    if (_mask.length < textNew.length) {
      String textOld = oldValue.text;
      return TextEditingValue(
        text: textOld,
        selection: TextSelection.collapsed(offset: textOld.length),
      );
    }

    String maskWithoutText = _mask.replaceAll("-", "");
    if (textNew.length == maskWithoutText.length) {
      String phoneWithMask = _changeNewToMask(textNew);
      return TextEditingValue(
        text: phoneWithMask,
        selection: TextSelection.collapsed(offset: phoneWithMask.length),
      );
    } else {
      if (textNew.contains("-")) {
        textNew = textNew.replaceAll("-", "");
      }

      int index = textNew.length;
      return TextEditingValue(
        text: textNew,
        selection: TextSelection.collapsed(offset: index),
      );
    }
  }

  String _changeNewToMask(String phone) {
    int phoneCount = 0;
    StringBuffer maskWithPhone = StringBuffer();
    for (int count = 0; count < _mask.length; count++) {
      if (_mask[count] == '#') {
        maskWithPhone.write(phone[phoneCount]);
        phoneCount++;
      } else {
        maskWithPhone.write(_mask[count]);
      }
    }

    return maskWithPhone.toString();
  }
}