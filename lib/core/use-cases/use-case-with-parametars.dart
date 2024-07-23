import 'package:dartz/dartz.dart';
import 'package:movie/core/network/failure.dart';


abstract class UseCase<T,param>{
  Future<Either<Failure,T>>call([param]);
}