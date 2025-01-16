abstract class AppError {
  final String message;

  AppError(this.message);

  @override
  String toString() => message;
}

class NetworkError extends AppError {
  NetworkError([String message = "Network error occurred"]) : super(message);
}

class UnexpectedError extends AppError {
  UnexpectedError([String message = "Unexpected error occurred"])
      : super(message);
}

class ValidationError extends AppError {
  ValidationError([String message = "Validation failed"]) : super(message);
}

AppError handleException(Exception e) {
  if (e.toString().contains("SocketException")) {
    return NetworkError("Please check your internet connection.");
  } else if (e.toString().contains("FormatException")) {
    return ValidationError("Invalid format encountered.");
  } else {
    return UnexpectedError(e.toString());
  }
}
