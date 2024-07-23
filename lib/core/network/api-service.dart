// ignore: file_names
import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;

  ApiServices({required this.dio});

  Future<Map<String, dynamic>> getData({required String endPoint}) async {
    try {
      Response response = await dio.get(endPoint);
      print('API Response: ${response.data}');
      return response.data;
    } catch (error) {
      print('API Error: $error');
      throw error;
    }
  }

  Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queries,
  }) async {
    return await dio.post(endPoint, data: data);
  }

  Future<Response> patchData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queries,
  }) async {
    return await dio.patch(
      endPoint,
      data: data,
    );
  }

  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queries,
  }) async {
    return await dio.delete(endPoint, data: data);
  }
}
