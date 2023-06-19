import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testinilab/api/get_home_data.dart';
import 'package:testinilab/customs/custom_image.dart';
import 'package:testinilab/getx/enter_screen/controller.dart';
import 'package:testinilab/screen/homepage.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  final controller = Get.put(EnterScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: controller.isDark,
            onChanged: (value) {
              setState(() {
                controller.isDark = value;
              });
              if(controller.isDark==true){
                Get.changeTheme(ThemeData.dark());
              }else{
                Get.changeTheme(ThemeData.light());
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CustomImage(
                height: 200,
                path:
                    "https://i.pinimg.com/originals/b1/5e/ed/b15eedbdafbbdbca3249e3942f4faf3b.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.usernameController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text(
                            "Please Enter Username",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )));
                    } else {
                      Get.to(HomePage());
                    }
                  },
                  child: const Text("Go Next"))
            ],
          ),
        ),
      ),
    );
  }
}
