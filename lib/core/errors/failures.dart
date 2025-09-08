// lib/core/error/failure.dart

sealed class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class StockFailure extends Failure {
  const StockFailure([String message = 'Insufficient stock']) : super(message);
}

class CutoffFailure extends Failure {
  const CutoffFailure([String message = 'Cutoff rule violated']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error']) : super(message);
}
