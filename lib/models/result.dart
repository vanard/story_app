sealed class Result {
  const Result();
}

final class Success extends Result {
  const Success(this.value);
  final dynamic value;
}

final class Failure extends Result {
  const Failure(this.exception);
  final Exception exception;
}