import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart';
import 'package:testinilab/model/home_model.dart';

class EnterScreenController extends GetxController{
  final usernameController = TextEditingController();
  bool isDark = false;
}