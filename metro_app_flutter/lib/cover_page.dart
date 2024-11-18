import 'package:flutter/material.dart';
import 'package:metrostation_app/home_page.dart';
import 'package:get/get.dart';
import 'translation.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/train2.jpg',
              width: double.infinity,
              fit: BoxFit.cover ,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 100, // Adjusted position for buttons
            left: 20,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.updateLocale(Locale('en'));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    foregroundColor: Colors.white// Black background
                  ),
                  child: Text('English'),
                ),
                SizedBox(width: 10), // Space between buttons
                TextButton(
                  onPressed: () {
                    Get.updateLocale(Locale('ar'));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                      foregroundColor: Colors.white// Black background
                  ),
                  child: Text('العربية'), // Arabic for "Arabic"
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
              right: 20,
              left: 20,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                 Get.to(HomePage());
                },
                  child: Text('Start'.tr,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue[300]),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size(80, 80)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                       ),
                    ),
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }
}
