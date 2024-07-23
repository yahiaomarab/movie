
import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';


abstract class UseCase<T>{
  Future<Either<Failure,T>>call();
}