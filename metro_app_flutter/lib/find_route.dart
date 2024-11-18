import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrostation_app/metrostation.dart';
import 'package:geolocator/geolocator.dart';

class FindRoute extends StatelessWidget {
   FindRoute({super.key});
   var isVisible=false.obs;
   void toggleVisibilty(){
     isVisible.value=!isVisible.value;
   }

  @override
  Widget build(BuildContext context) {
    final arguments= Get.arguments;
    final List<String> route = List<String>.from(arguments['route'] ?? []);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Route'.tr,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        width:double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${arguments['start']}',
                   style: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward,
                  color: Colors.black,),
                Text(
                  '${arguments['destination']}' ,
                   style: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Direction: '.tr + '${arguments['direction']}',
                     style:TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 20,
                     ) ,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Change Station At: '.tr + '${arguments['change station']}',
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                     ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Number Of Stations: '.tr + '${arguments['number of stations']} Stations' ,
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                     ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Time: '.tr + '${arguments['hour']} hr  ${arguments['minute']} min',
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                     ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Ticket: '.tr + '${arguments['ticket']} EGP' ,
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                     ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Route'.tr,
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                     ),
                  ),
                  trailing: Icon(Icons.arrow_downward,
                  color: Colors.black,
                  ),
                  onTap: toggleVisibilty,
                ),
                Obx(() => Visibility(
                  visible: isVisible.value,
                    child: Padding(
                        padding:EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: route.map((station) => Text(
                          station,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20),
                        )).toList(),
                      )
                    )
                )
                ),
                SizedBox(
                  height: 20,
                ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton.icon(onPressed: () async {
                        var indexCurrent = 0 ;
                        var indexDestination = 0;

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

                          final locationCurrent = await Geolocator.getCurrentPosition();
                          final latitudeCurrent = locationCurrent.latitude;
                          final longitudeCurrent = locationCurrent.longitude;

                          var min = double.maxFinite;
                          for (int i = 0; i < metroStations.length; i++) {
                            final distance = Geolocator.distanceBetween(latitudeCurrent, longitudeCurrent,
                                metroStations[i].latitude, metroStations[i].longitude);
                            if (distance < min) {
                              min = distance;
                              indexCurrent = i;
                            }
                          }

                        var indexCurrentName=metroStations[indexCurrent].name;
                        var indexCurrentStation=route.indexOf(indexCurrentName) +1;

                        var destination = arguments['destination'] as String;
                        indexDestination=route.indexOf(destination) +1;

                        int stationsLeft = (indexCurrentStation- indexDestination).abs(); // The number of stations between the current and destination
                        double timePerStation = 2.0; // Let's assume 2 minutes per station
                        double totalTime = stationsLeft * timePerStation;

                         Get.snackbar(
                             "Route Info".tr,
                             "Stations left: ".tr + "$stationsLeft, " + "Estimated time: ".tr + "$totalTime minutes");
                      },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                          icon: Icon(Icons.search),
                          label: Text('Find Remaining stations and time'.tr),
                      ),
                 ],
               ),
              ],
            )
            )
          ],
        ),
      ),
    );
  }
}
