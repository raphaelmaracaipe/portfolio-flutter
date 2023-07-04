import 'dart:convert';

class CountryModel {
  final String countryName;
  final String codeCountry;
  final String codeIson;
  final String mask;

  CountryModel({
    required this.codeCountry,
    required this.countryName,
    required this.codeIson,
    required this.mask,
  });

  String toJSONString() {
    Map<String, dynamic> countryModelMap = {
      "code_country": codeCountry,
      "country_name": countryName,
      "code_ison": codeIson,
      "mask": mask,
    };
    return jsonEncode(countryModelMap);
  }

  Map<String, dynamic> toJSON() {
    return {
      "code_country": codeCountry,
      "country_name": countryName,
      "code_ison": codeIson,
      "mask": mask,
    };
  }

  factory CountryModel.fromJSON(Map<String, dynamic> json){
    return CountryModel(
      codeCountry: json['code_country'],
      countryName: json['country_name'],
      codeIson: json['code_ison'],
      mask: json['mask'],
    );
  }
}
