class Location {
  final String name;
  final String isoCode;
  final String countryCode;
  final String latitude;
  final String longitude;

  Location({required this.name, required this.isoCode, required this.countryCode, required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? '',
      isoCode: json['isoCode'] ?? '',
      countryCode: json['countryCode'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  // Convert to map for compatibility with existing code
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isoCode': isoCode
    };
  }
}

class Country {
  final String name;
  final String isoCode;
  final String flag;
  final String phoneCode;
  final String currency;
  final String latitude;
  final String longitude;

  const Country({
    required this.name,
    required this.isoCode,
    required this.flag,
    required this.phoneCode,
    required this.currency,
    required this.latitude,
    required this.longitude,
  });

  // Factory constructor to create a Country from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      isoCode: json['isoCode'] ?? '',
      flag: json['flag'] ?? '',
      phoneCode: json['phonecode'] ?? '',
      currency: json['currency'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

class CountryUtils {
  // List of countries (you'd typically load this from a JSON file or database)
  static final List<Country> countryList = [
    const Country(
      name: "Canada",
      isoCode: "CA",
      flag: "🇨🇦",
      phoneCode: "1",
      currency: "CAD",
      latitude: "60.00000000",
      longitude: "-95.00000000",
    ),
    const Country(
      name: "Germany",
      isoCode: "DE",
      flag: "🇩🇪",
      phoneCode: "49",
      currency: "EUR",
      latitude: "51.00000000",
      longitude: "9.00000000",
    ),
    const Country(
      name: "United Kingdom",
      isoCode: "GB",
      flag: "🇬🇧",
      phoneCode: "44",
      currency: "GBP",
      latitude: "54.00000000",
      longitude: "-2.00000000",
    ),
    const Country(
      name: "United States",
      isoCode: "US",
      flag: "🇺🇸",
      phoneCode: "1",
      currency: "USD",
      latitude: "38.00000000",
      longitude: "-97.00000000",
    ),
    const Country(
      name: "Nigeria",
      isoCode: "NG",
      flag: "🇳🇬",
      phoneCode: "234",
      currency: "NGN",
      latitude: "9.08199900",
      longitude: "8.67528000",
    ),
  ];

  // Get a country by ISO code
  static Country? getCountryByCode(String isoCode) {
    if (isoCode.isEmpty) return null;
    
    try {
      return countryList.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Get all countries
  static List<Country> getAllCountries() {
    return countryList;
  }

  // Sort countries by ISO code
  static List<Country> sortByIsoCode(List<Country> countries) {
    final sortedList = List<Country>.from(countries);
    sortedList.sort((a, b) => a.isoCode.compareTo(b.isoCode));
    return sortedList;
  }

  // Check if country is supported by name
  static bool isCountrySupportedByName(String name) {
    return countryList.any(
      (country) => country.name.toLowerCase() == name.toLowerCase(),
    );
  }

  // Check if country is supported by ISO code
  static bool isCountrySupportedByIsoCode(String isoCode) {
    return countryList.any(
      (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
    );
  }

  // Get country ISO code by name
  static String getCountryIsoCode(String countryName) {
    try {
      final country = countryList.firstWhere(
        (country) => country.name.toLowerCase() == countryName.toLowerCase(),
      );
      return country.isoCode;
    } catch (e) {
      return '';
    }
  }



  //

    static Country? getCountryByName(String countryName) {
    return countryList.firstWhere(
      (country) => country.name.toLowerCase() == countryName.toLowerCase(),
      orElse: () => null!,
    );
  }

  static Country? CountryUtilsgetCountryByCode(String isoCode) {
    return countryList.firstWhere(
      (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      orElse: () => null!,
    );
  }

  // static List<Country> getAllCountries() {
  //   return countryList;
  // }

  static List<Map<String, dynamic>> formatCountries(List<Country> countries) {
    return countries
        .map((country) => {'uuid': country.name, 'value': country.name})
        .toList();
  }
}




// class CountryUtils {
//   static final List<Country> countryList = [
//     // List of countries (Add your existing JSON list here)
//   ];

//   static Country? getCountryByName(String countryName) {
//     return countryList.firstWhere(
//       (country) => country.name.toLowerCase() == countryName.toLowerCase(),
//       orElse: () => null,
//     );
//   }

//   static Country? CountryUtilsgetCountryByCode(String isoCode) {
//     return countryList.firstWhere(
//       (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
//       orElse: () => null,
//     );
//   }

//   static List<Country> getAllCountries() {
//     return countryList;
//   }

//   static List<Map<String, dynamic>> formatCountries(List<Country> countries) {
//     return countries
//         .map((country) => {'uuid': country.name, 'value': country.name})
//         .toList();
//   }
// }


// Get a country by ISO code
Country? canada = CountryUtils.getCountryByCode('CA');

// Check if a country is supported
bool isUSSupported = CountryUtils.isCountrySupportedByName('United States');

// Get all countries
List<Country> countries = CountryUtils.getAllCountries();