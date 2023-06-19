import 'package:dio/dio.dart';

final dio = Dio();

class ApiServices{

  static getHomeData(username) async {
    Response response;
    response = await dio.get('https://api.github.com/users/$username');
    return response;
  }

}