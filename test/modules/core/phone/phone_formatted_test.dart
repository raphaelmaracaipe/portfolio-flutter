import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/modules/core/data/assets/models/country_model.dart';
import 'package:portfolio_flutter/modules/core/phone/phone_formatted.dart';

void main() {
  group("FormattedPhone", () {
    final FormattedPhone formattedPhone = FormattedPhone(
      countryModel: CountryModel(
        codeCountry: "AAA",
        countryName: "BBB",
        codeIson: "CCC",
        mask: "####-####",
      ),
    );

    test('when inform phone and formatted phone', () {
      TextEditingValue textEditingValueOld = const TextEditingValue(
        text: "1234567",
      );
      TextEditingValue textEditingValueNew = const TextEditingValue(
        text: "12345678",
      );

      TextEditingValue result = formattedPhone.formatEditUpdate(
        textEditingValueOld,
        textEditingValueNew,
      );

      expect("1234-5678", result.text);
    });

    test('when inform phone and formatted phone but not stop digits', () {
      TextEditingValue textEditingValueOld = const TextEditingValue(
        text: "1234-5678",
      );
      TextEditingValue textEditingValueNew = const TextEditingValue(
        text: "1234-56789",
      );

      TextEditingValue result = formattedPhone.formatEditUpdate(
        textEditingValueOld,
        textEditingValueNew,
      );

      expect("1234-5678", result.text);
    });

    test('when information phone not completed', () {
      TextEditingValue textEditingValueOld = const TextEditingValue(
        text: "12345",
      );
      TextEditingValue textEditingValueNew = const TextEditingValue(
        text: "123456",
      );

      TextEditingValue result = formattedPhone.formatEditUpdate(
        textEditingValueOld,
        textEditingValueNew,
      );

      expect("123456", result.text);
    });
  });
}
