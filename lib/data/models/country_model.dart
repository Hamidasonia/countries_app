import '../entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.name,
    required super.capital,
    required super.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    try {
      String name = '-';
      String capital = '-';
      String flag = '';

      // Extract name
      if (json['name'] is Map && json['name']['common'] != null) {
        name = json['name']['common'].toString();
      }

      // Extract capital
      if (json['capital'] is List && (json['capital'] as List).isNotEmpty) {
        capital = (json['capital'] as List)[0].toString();
      }

      // Extract flag
      if (json['flags'] is Map && json['flags']['png'] != null) {
        flag = json['flags']['png'].toString();
      }

      return CountryModel(
        name: name,
        capital: capital,
        flag: flag,
      );
    } catch (e) {
      print('Error parsing country: $e');
      return const CountryModel(
        name: '-',
        capital: '-',
        flag: '',
      );
    }
  }
}