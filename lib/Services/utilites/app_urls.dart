class AppUrl{
  // this is our base url
  static const String baseUrl = ' https://disease.sh/v3/covid-19/';
  // fetch world covid stats
  static const String worldStatsApi = baseUrl + 'all';
  static const String countryList= baseUrl + 'countries';
}