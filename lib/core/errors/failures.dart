// lib/core/error/failure.dart

sealed class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class StockFailure extends Failure {
  const StockFailure([super.message = 'Insufficient stock']);
}

class CutoffFailure extends Failure {
  const CutoffFailure([super.message = 'Cutoff rule violated']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}
