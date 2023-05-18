class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException(this.message, this.prefix, this.url);
}

class BadRequestException extends AppException {
  BadRequestException(String decode, String? string,
      {required String message, required String url})
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException(String message, String url)
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException(String message, String url)
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException(String message, String url)
      : super(message, 'UnAuthorized request', url);
}

class InvalidInputException extends AppException {
  InvalidInputException(String message, String url)
      : super(message, 'Invalid Input', url);
}

class NoInternetException extends AppException {
  NoInternetException(String message, String url)
      : super(message, 'No Internet', url);
}

class UnknownException extends AppException {
  UnknownException(String message, String url)
      : super(message, 'Unknown Exception', url);
}

class ServerException extends AppException {
  ServerException(String message, String url)
      : super(message, 'Server Exception', url);
}

class CacheException extends AppException {
  CacheException(String message, String url)
      : super(message, 'Cache Exception', url);
}

class SocketException extends AppException {
  SocketException(String message, String url)
      : super(message, 'Socket Exception', url);
}

class TimeoutException extends AppException {
  TimeoutException(String message, String url)
      : super(message, 'Timeout Exception', url);
}

class NoServiceFoundException extends AppException {
  NoServiceFoundException(String message, String url)
      : super(message, 'No Service Found Exception', url);
}

// 404 not found
class NotFoundException extends AppException {
  NotFoundException(String message, String url)
      : super(message, 'Not Found Exception', url);
}

// internal server error
class InternalServerErrorException extends AppException {
  InternalServerErrorException(String message, String url)
      : super(message, 'Internal Server Error Exception', url);
}
