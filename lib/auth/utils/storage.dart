class Storage {
  // Variabel statis untuk menyimpan token
  static String _token = '';

  // Getter untuk mengambil token
  static String get token => _token;

  // Setter untuk mengatur token
  static set token(String value) {
    _token = value;
  }

  // Metode untuk mengosongkan token
  static void clearToken() {
    _token = '';
  }
}
