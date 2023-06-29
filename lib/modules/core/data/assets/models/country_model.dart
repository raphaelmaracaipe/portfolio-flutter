class CountryModel {
  final String countryName;
  final String codeCountry;
  final String codeIson;

  CountryModel({
    required this.codeCountry,
    required this.countryName,
    required this.codeIson,
  });

  factory CountryModel.fromJSON(Map<String, dynamic> json) {
    return CountryModel(
      codeCountry: json['code_country'],
      countryName: json['country_name'],
      codeIson: json['code_ison'],
    );
  }
}
