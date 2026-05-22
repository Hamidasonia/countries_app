class CountryModel {
  final String name;
  final String capital;
  final String flag;

  CountryModel({
    required this.name,
    required this.capital,
    required this.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    
    String countryName = 'Unknown Country';
    if (json['name'] != null) {
      if (json['name'] is Map) {
        countryName = json['name']['common'] ?? json['name']['official'] ?? 'Unknown Country';
      } else {
        countryName = json['name'].toString();
      }
    }

    String capitalCity = 'N/A';
    if (json['capital'] != null) {
      if (json['capital'] is List) {
        List capitalList = json['capital'] as List;
        // INI KUNCINYA: Cek dulu jumlah baris/length sebelum ambil indeks [0]
        if (capitalList.isNotEmpty) {
          capitalCity = capitalList[0].toString();
        }
      } else if (json['capital'] is String) {
        capitalCity = json['capital'].toString();
      }
    }

    String flagUrl = '';
    if (json['flags'] != null && json['flags'] is Map) {
      flagUrl = json['flags']['png'] ?? json['flags']['svg'] ?? '';
    } else if (json['flag'] != null) {
      flagUrl = json['flag'].toString();
    }

    return CountryModel(
      name: countryName,
      capital: capitalCity,
      flag: flagUrl,
    );
  }
}