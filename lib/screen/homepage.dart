import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testinilab/const/const_data.dart';
import 'package:testinilab/customs/custom_image.dart';
import 'package:testinilab/getx/enter_screen/controller.dart';
import 'package:testinilab/getx/home_controller.dart';
import 'package:testinilab/screen/repo_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomeScreenController());
  final enterScreenController = Get.put(EnterScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getHomeData(enterScreenController.usernameController.text);
    controller.getRepoData(enterScreenController.usernameController.text, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${controller.homeModel?.avatarUrl}",
                          ),
                          radius: 40,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.homeModel?.login}".isNotEmpty ? "${controller.homeModel?.login}" : "${controller.homeModel?.name}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomImage(
                                  path:
                                      'https://ilaks.no/wp-content/uploads/2014/02/v65oai7fxn47qv9nectx.png',
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("@${controller.homeModel?.twitterUsername}")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.people),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "${controller.homeModel?.followers} follower"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "${controller.homeModel?.following} following")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.isListClick.value = true;
                              },
                              child: Icon(
                                Icons.format_list_numbered_sharp,
                                color: controller.isListClick.value
                                    ? Colors.blue
                                    : Colors.black,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 5,),
                            GestureDetector(
                              onTap: () {
                                controller.isListClick.value = false;
                              },
                              child: Icon(
                                Icons.grid_view_sharp,
                                size: 20,
                                color: controller.isListClick.value
                                    ? Colors.black
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Icon(Icons.filter_list_alt),
                            SizedBox(
                              child: PopupMenuButton(
                                  icon: Material(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.shade300,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text('${controller.sortByValue}'),
                                    ),
                                  ),
                                  tooltip: "Sort By",
                                  itemBuilder: (context) => <PopupMenuEntry>[
                                        ...List.generate(Const.sortList.length,
                                            (index) {
                                          // print("Length ${state.homeModel.topCountries.length}");
                                          return PopupMenuItem(
                                            onTap: () {
                                              controller.sortByValue.value =
                                                  Const.sortList[index]
                                                      ['name']!;
                                              controller.sortBy.value = Const
                                                  .sortList[index]['value']!;
                                              controller.getRepoData(
                                                  enterScreenController
                                                      .usernameController.text,
                                                  controller.sortBy.value);
                                            },
                                            child: Text(
                                                "${Const.sortList[index]['name']}"),
                                          );
                                        }),
                                      ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(
                        () => controller.isListLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.isListClick.value
                                ? ListView.separated(
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RepoDetailsScreen(
                                              repoModel: controller.repoModel[index],avaterUrl: controller.homeModel!.avatarUrl,
                                              name: controller.homeModel!.name,
                                            login: controller.homeModel!.login,
                                          ),

                                          ));
                                        },
                                        child: Container(
                                          height: 90,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                      controller
                                                          .repoModel[index].name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration: BoxDecoration(
                                                            color: "${controller.repoModel[index].language}" ==
                                                                    "Dart"
                                                                ? Colors.teal
                                                                : "${controller.repoModel[index].language}" ==
                                                                        "Java"
                                                                    ? Colors.brown
                                                                    : "${controller.repoModel[index].language}" ==
                                                                            "HTML"
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .pink,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          "${controller.repoModel[index].language}"),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "Update on ${DateFormat('MMM d').format(DateTime.parse("${controller.repoModel[index].updatedAt}"))}")
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                ),
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                alignment: Alignment.center,
                                                child: Text(controller
                                                    .repoModel[index].visibility),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: controller.repoModel.length,
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RepoDetailsScreen(repoModel: controller.repoModel[index],
                                            avaterUrl: controller.homeModel!.avatarUrl, name: controller.homeModel!.name, login: controller.homeModel!.login),));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  '${controller.repoModel[index].name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                      color: "${controller.repoModel[index].language}" ==
                                                              "Dart"
                                                          ? Colors.teal
                                                          : "${controller.repoModel[index].language}" ==
                                                                  "Java"
                                                              ? Colors.brown
                                                              : "${controller.repoModel[index].language}" ==
                                                                      "HTML"
                                                                  ? Colors.red
                                                                  : Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      "${controller.repoModel[index].language}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  "Update on ${DateFormat('MMM d').format(DateTime.parse("${controller.repoModel[index].updatedAt}"))}"),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(40),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                  ),
                                                  width: 70,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 0),
                                                  alignment: Alignment.center,
                                                  child: Text(controller
                                                      .repoModel[index]
                                                      .visibility),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.repoModel.length),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
