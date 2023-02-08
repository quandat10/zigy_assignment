class Endpoints {
  Endpoints._();
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 15000;

  static const String baseUrl = "https://reqres.in/api";
  static const String listUsersUrl = "$baseUrl/users?page=2";
  static const String newUserApi = "$baseUrl/users";
}
