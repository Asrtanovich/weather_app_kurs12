import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_kurs12/modules/home/controller/home_controller.dart';
import 'package:weather_app_kurs12/modules/search/view/search_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () async {
              await controller.showWeatherByLocation();
            },
            child: Icon(
              Icons.near_me,
              size: 50,
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                final String typedCityName = await Get.to(SearchView());
                await controller.getSearchedCityName(typedCityName);
              },
              child: Icon(
                Icons.location_city,
                size: 50,
              ),
            ),
          ],
        ),
        body: controller.isLoading.value == true
            ? Center(
                child: Obx(() => CircularProgressIndicator(
                      color: Colors.red,
                      backgroundColor: Colors.green,
                    )),
              )
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: 160,
                      child: Obx(() => Text(
                            controller.icons.value,
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 130,
                      left: 40,
                      child: Obx(() => Text(
                            '${controller.tempreture.value}\u2103',
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 50,
                      left: 40,
                      child: Obx(() => Text(
                            'Country: ${controller.country.value} ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 280,
                      left: 0,
                      right: 50,
                      child: Obx(() => Text(
                            controller.description.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Positioned(
                      top: 320,
                      // left: ,
                      right: 0,
                      child: Text(
                        '👚',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 500,
                      left: 30,
                      // right: 0,
                      child: Obx(() => Text(
                            controller.cityName.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
