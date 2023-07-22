// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';

// class DioHelper
// {
//   static late Dio dio;  // Take object form Dio (dio)
//
//   static init()    // to create this object
//   {
//     dio = Dio(  //definition dio
//       BaseOptions(
//         baseUrl: 'https://newsapi.org/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }
//
//  static Future<Response>  postData({
//     required String url,
//     required Map<String, dynamic> query,
//   })
//   async {
//     return await dio.get(url, queryParameters: query);
//   }
// }


class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
})
  async {
    dio.options.headers =
        {
          'Content-Type':'application/json',
          'lang':lang,
          'Authorization' : token??'',
        };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
     required String url,
     Map<String,dynamic>? query,
     required Map<String,dynamic> data,
    String lang = 'en',
    String? token,
 }) async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }
}