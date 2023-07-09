import 'dart:io';
import 'package:dio/dio.dart';

const endPoint = 'https://reqres.in';
 String imagestorageendpoint = 'https://reqres.in/img/';
Dio client = new Dio();

Future<List<dynamic>> userslist(int currentPage) async {
  try {
    dynamic user_list = {};
    var response = await client.get('$endPoint/api/users?page=$currentPage');
    user_list = response.data;
    return user_list['data'];
  } on DioError catch (e) {
    return [];
  }
}

Future<dynamic> userDetails(int unique_id) async {
  try {
    var response = await client.get('$endPoint/api/users/$unique_id');
    final userDetails = response.data['data'];
    return [userDetails];
  } on DioError catch (e) {
    return [];
  }
}

