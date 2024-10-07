import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';


abstract class UseCase<T,param>{
  Future<Either<Failure,T>>call([param]);
}
abstract class UseCaseWithString<T,param,paramString>{
  Future<Either<Failure,T>>call([param,paramString]);
}