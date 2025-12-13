import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class ProductFailure extends Failure {
  final String message;

  const ProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}
