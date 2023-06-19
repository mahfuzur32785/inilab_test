import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart';
import 'package:testinilab/model/home_model.dart';
import 'package:testinilab/model/repo_model.dart';

class HomeScreenController extends GetxController{

  RxBool isLoading = false.obs;
  RxBool isListClick = true.obs;
  RxString sortBy = ''.obs;
  RxString sortByValue = 'Sort By'.obs;

  HomeModel? homeModel;

  final dio = Dio();
  getHomeData(username) async {
    try{
      isLoading(true);

      Response? result;
      result = await dio.get('https://api.github.com/users/$username');

      if(result.statusCode == 200){
        var data = result.data;
        homeModel = HomeModel.fromMap(data);
      }
      // print('result ${homeModel!.name}');

    }catch(e){
      print("error $e");
    }finally{
      isLoading(false);
    }
  }

  List<RepoModel> repoModel = [];
  RxBool isListLoading = false.obs;
  getRepoData(username, sortBy)async{
    try{
      isListLoading(true);
      Response? result;
      result = await dio.get('https://api.github.com/users/$username/repos?sort=$sortBy');

      if(result.statusCode == 200){
        var data = result.data;
        repoModel = List<dynamic>.from(data).map((e) => RepoModel.fromMap(e)).toList();
        print('result ${data}');
      }
    }catch(e){
      print("error $e");
    }finally{
      isListLoading(false);
    }
  }

}