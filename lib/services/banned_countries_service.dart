import 'package:shared_preferences/shared_preferences.dart';

class BannedCountriesService {
  static final BannedCountriesService _instance =
      BannedCountriesService._internal();

  factory BannedCountriesService() {
    return _instance;
  }

  BannedCountriesService._internal();

  List<String> bannedCountries = [];

  Future<void> loadBannedCountries() async {
    final prefs = await SharedPreferences.getInstance();
    bannedCountries = prefs.getStringList('bannedCountries') ?? [];
  }

  Future<void> saveBannedCountries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bannedCountries', bannedCountries);
  }

  void addCountry(String country) {
    if (!bannedCountries.contains(country)) {
      bannedCountries.add(country);
      saveBannedCountries();
    }
  }

  void removeCountry(String country) {
    if (bannedCountries.contains(country)) {
      bannedCountries.remove(country);
      saveBannedCountries();
    }
  }
}
