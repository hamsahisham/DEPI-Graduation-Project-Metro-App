import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:metrostation_app/home_page.dart';
import 'package:metrostation_app/metrostation.dart';

class NearestStation extends StatelessWidget {
  NearestStation({super.key});

  final nearestStationController = TextEditingController();
  final destinationController = TextEditingController();
  var indexCurrent = 0 ;
  var indexDestination = 0;

  Future<void> showLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location is disabled'.tr);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied'.tr);
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.'.tr);
      return;
    }

    final location = await Geolocator.getCurrentPosition();
    final latitude = location.latitude;
    final longitude = location.longitude;

    var min = double.maxFinite;
    for (int i = 0; i < metroStations.length; i++) {
      final distance = Geolocator.distanceBetween(latitude, longitude,
          metroStations[i].latitude, metroStations[i].longitude);
      if (distance < min) {
        min = distance;
        indexCurrent = i;
      }
    }
      nearestStationController.text = '${metroStations[indexCurrent].name}';
      Get.snackbar('Nearest Station' .tr, metroStations[indexCurrent].name);
  }

  Future<void> findNearestToDestination() async {
    final location = await locationFromAddress(destinationController.text);
    if (location.isEmpty || destinationController.text.isEmpty) {
      Get.snackbar("Error", 'Enter a destination'.tr);
      return;
    }
    var latitude = location.first.latitude;
    var longitude = location.first.longitude;

    var min = double.maxFinite;
    for (int i = 0; i < metroStations.length; i++) {
      final distance = Geolocator.distanceBetween(latitude, longitude,
          metroStations[i].latitude, metroStations[i].longitude);
      if (distance < min) {
        min = distance;
        indexDestination = i;
      }
    }
  //  destinationController.text = metroStations[lit].name;
     Get.snackbar("Nearest To Destination".tr, metroStations[indexDestination].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Nearest Station'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.train),
              title: Text('Home'.tr),
              onTap: () {
                Get.to(HomePage());
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Nearest Station'.tr),
              onTap: () {
                Get.to(NearestStation());
              },
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearest Station'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: nearestStationController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nearest Station'.tr,
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed:
                        showLocation,
                      child: Text('Find Nearest Station'.tr,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(60, 50)),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Nearest To Destination'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: destinationController,
                   //   readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nearest To Destination'.tr),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed:
                        findNearestToDestination,
                      child: Text('Find Nearest To Destination'.tr,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(60, 50)),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
