import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';


abstract class UseCase<T,param>{
  Future<Either<Failure,T>>call([param]);
}
abstract class UseCaseWithAntherParam<T,param,antherParam>{
  Future<Either<Failure,T>>call([param,antherParam]);
}