part of petisland_core.exception;

class PetException implements Exception {
  String message;
  String stackTrace;

  PetException([this.message, this.stackTrace]);

  PetException.fromException(dynamic ex)
      : message = ex.message,
        stackTrace = ex is DioError ? ex.error : ex.stackTrace;

  @override
  String toString() => '$runtimeType:: $message $stackTrace';
}
