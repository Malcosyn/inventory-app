
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class InvalidEmailException implements Exception {}

class InvalidPasswordException implements Exception {}