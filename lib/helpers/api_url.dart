class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api/buku/isbn';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listIsbn = baseUrl + '/isbn';
  static const String createIsbn = baseUrl + '/isbn';
  
  static String updateIsbn(int id) {
  return baseUrl + '/isbn/' + id.toString();
  }

  static String showIsbn(int id) {
   return baseUrl + '/isbn/' + id.toString();
  }
  static String deleteIsbn(int id) {
    return baseUrl + '/isbn/' + id.toString();
  }
}
