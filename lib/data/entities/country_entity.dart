import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String name;
  final String capital;
  final String flag;

  const CountryEntity({
    required this.name,
    required this.capital,
    required this.flag,
  });

  @override
  List<Object?> get props => [
        name,
        capital,
        flag,
      ];
}