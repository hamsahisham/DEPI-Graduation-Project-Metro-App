import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrostation_app/find_route.dart';
import 'package:metrostation_app/nearest_station.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final start=<String>["Helwan", "Ain Helwan", "Helwan University", "Wadi Hof", "Hadayek Helwan", "El-Maasara", "Tora El-Asmant", "Kozzika", "Tora El-Balad", "Sakanat El-Maadi", "Maadi", "Hadayek El-Maadi", "Dar El-Salam", "El-Zahraa", "Mar Girgis", "El-Malek El-Saleh", "Al-Sayeda Zeinab", "Saad Zaghloul", "Sadat", "Nasser", "Orabi", "Al-Shohadaa", "Ghamra", "El-Demerdash", "Manshiet El-Sadr", "Kobri El-Qobba", "Hammamat El-Qobba", "Saray El-Qobba", "Hadayeq El-Zaitoun", "Helmeyet El-Zaitoun", "El-Matareyya", "Ain Shams", "Ezbet El-Nakhl", "El-Marg", "New El-Marg","El-Mounib", "Sakiat Mekky", "El Giza", "faisal", "Cairo University", "El Bohoth", "Dokki", "opera", "Mohamed Naguib", "Attaba", "Masarra", "Road El-Farag", "St. Teresa", "Khalafawy", "Mezallat", "Kolleyyet El-Zeraa", "Shubra El-Kheima","Adly Mansour","El Haykestep","Omar Ibn El Khattab","Qobaa","Hesham Barakat","El Nozha","Nadi El Shams","Alf Maskan","Heliopolis Square","Helmyet El Zaitoun","Haroun","Al Ahram","Koleyet El Banat","Stadium","Fair Zone","Abbassia","Abdo Basha","El Geish","Bab El Shaaria","Maspero","Zamalek","Kit Kat","Sudan","Imbaba","El Bohy","El-Qawmia","Ring Road","Rod El Farag"].obs;
  final destination=<String>["Helwan", "Ain Helwan", "Helwan University", "Wadi Hof", "Hadayek Helwan", "El-Maasara", "Tora El-Asmant", "Kozzika", "Tora El-Balad", "Sakanat El-Maadi", "Maadi", "Hadayek El-Maadi", "Dar El-Salam", "El-Zahraa", "Mar Girgis", "El-Malek El-Saleh", "Al-Sayeda Zeinab", "Saad Zaghloul", "Sadat", "Nasser", "Orabi", "Al-Shohadaa", "Ghamra", "El-Demerdash", "Manshiet El-Sadr", "Kobri El-Qobba", "Hammamat El-Qobba", "Saray El-Qobba", "Hadayeq El-Zaitoun", "Helmeyet El-Zaitoun", "El-Matareyya", "Ain Shams", "Ezbet El-Nakhl", "El-Marg", "New El-Marg","El-Mounib", "Sakiat Mekky", "El Giza", "faisal", "Cairo University", "El Bohoth", "Dokki", "opera", "Mohamed Naguib", "Attaba", "Masarra", "Road El-Farag", "St. Teresa", "Khalafawy", "Mezallat", "Kolleyyet El-Zeraa", "Shubra El-Kheima","Adly Mansour","El Haykestep","Omar Ibn El Khattab","Qobaa","Hesham Barakat","El Nozha","Nadi El Shams","Alf Maskan","Heliopolis Square","Helmyet El Zaitoun","Haroun","Al Ahram","Koleyet El Banat","Stadium","Fair Zone","Abbassia","Abdo Basha","El Geish","Bab El Shaaria","Maspero","Zamalek","Kit Kat","Sudan","Imbaba","El Bohy","El-Qawmia","Ring Road","Rod El Farag"].obs;
  final SController=TextEditingController();
  final DController=TextEditingController();

  final List<String> lineOne=["Helwan", "Ain Helwan", "Helwan University", "Wadi Hof", "Hadayek Helwan", "El-Maasara", "Tora El-Asmant", "Kozzika", "Tora El-Balad", "Sakanat El-Maadi", "Maadi", "Hadayek El-Maadi", "Dar El-Salam", "El-Zahraa", "Mar Girgis", "El-Malek El-Saleh", "Al-Sayeda Zeinab", "Saad Zaghloul", "Sadat", "Nasser", "Orabi", "Al-Shohadaa", "Ghamra", "El-Demerdash", "Manshiet El-Sadr", "Kobri El-Qobba", "Hammamat El-Qobba", "Saray El-Qobba", "Hadayeq El-Zaitoun", "Helmeyet El-Zaitoun", "El-Matareyya", "Ain Shams", "Ezbet El-Nakhl", "El-Marg", "New El-Marg"];
  final List<String> lineTwo=["El-Mounib", "Sakiat Mekky", "El Giza", "faisal", "Cairo University", "El Bohoth", "Dokki", "opera", "Sadat", "Mohamed Naguib", "Attaba", "Al-Shohadaa", "Masarra", "Road El-Farag", "St. Teresa", "Khalafawy", "Mezallat", "Kolleyyet El-Zeraa", "Shubra El-Kheima"];
  final List<String> lineThree=["Adly Mansour","El Haykestep","Omar Ibn El Khattab","Qobaa","Hesham Barakat","El Nozha","Nadi El Shams","Alf Maskan","Heliopolis Square","Helmyet El Zaitoun","Haroun","Al Ahram","Koleyet El Banat","Stadium","Fair Zone","Abbassia","Abdo Basha","El Geish","Bab El Shaaria","Attaba","Nasser","Maspero","Zamalek","Kit Kat","Sudan","Imbaba","El Bohy","El-Qawmia","Ring Road","Rod El Farag"];

  late final List<List<String>> lines;


  var startLine=<String>[];
  var destinationLine=<String>[];

  int indexStart=0;
  int indexDestination=0;

  final changeStations=<String>["Sadat", "Attaba", "Al-Shohadaa", "Nasser"];
  int changeIndexStart=0;
  int changeIndexDestination=0;
  String changeStation='';

  var route=<String>[];
  var sublist1=<String>[];
  var sublist2=<String>[];

  String direction='';

  int numOfStations=0;
  int time=0;
  int hours=0;
  int minutes=0;

  int ticket=0;

  @override
  Widget build(BuildContext context) {
    lines=[lineOne, lineTwo, lineThree];
    start.sort();
    destination.sort();
    return Scaffold(
     appBar: AppBar(
      title:  Text('Metro Station'.tr,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
       iconTheme: IconThemeData(
         color: Colors.white,
       ),
    ),
         drawer: Drawer(
           child: ListView(
             padding: EdgeInsets.zero,
             children: <Widget>[
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
               ), ListTile(
                 leading: Icon(Icons.train),
                 title: Text('Home'.tr),
                 onTap: (){
                   Get.to(HomePage());
                 }
               ),
               ListTile(
                 leading: Icon(Icons.location_on),
                 title: Text('Nearest Station'.tr),
                 onTap: (){
                   Get.to(NearestStation());
                 }
               ),
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
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
               padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose Station'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20,
                            )]
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                ),
                                child: Obx(() {
                                  return Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        final uri = Uri.parse(
                                            'geo:0,0?q=${SController.text}+metro+station+egypt');
                                        launchUrl(uri);
                                      },
                                          icon: Icon(Icons.map),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: DropdownMenu(
                                          controller: SController,
                                          width: double.infinity,
                                          enableSearch: true,
                                          enableFilter: true,
                                          hintText: 'Start Station'.tr,
                                          dropdownMenuEntries: start.map((name) =>
                                              DropdownMenuEntry(value: name, label: name)).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                ),
                                child: Obx(() {
                                  return Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        String temp = SController.text;
                                        SController.text = DController.text;
                                        DController.text = temp;
                                      },
                                        icon: Icon(Icons.swap_vert),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: DropdownMenu<String>(
                                          controller: DController,
                                          width: double.infinity,
                                          enableSearch: true,
                                          enableFilter: true,
                                          hintText: 'Destination'.tr,
                                          dropdownMenuEntries: destination.map((name) =>
                                             DropdownMenuEntry(value: name, label: name)).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: (){

                            //clearing list
                            route.clear();
                            sublist1.clear();
                            sublist2.clear();

                            //controller
                            final start=SController.text;
                            final destination=DController.text;

                            //start line and destination line
                            for(List<String> line in lines){
                              if(line.contains(start)){
                                startLine= line;
                                indexStart=line.indexOf(start);
                              }
                              if(line.contains(destination)){
                                destinationLine=line;
                                indexDestination=line.indexOf(destination);
                              }
                            }

                            //change stations
                            if(startLine != destinationLine){
                              for(String cs in changeStations){
                                if(startLine.contains(cs) && destinationLine.contains(cs)){
                                  changeIndexStart=startLine.indexOf(cs);
                                  changeIndexDestination=destinationLine.indexOf(cs);
                                  changeStation=cs;
                                  break;
                                }
                              }
                            }else {
                              changeStation= 'Stay On The Same Line'.tr;
                            }

                            //route and direction
                            if(startLine != destinationLine){
                              if(indexStart<changeIndexStart){
                                route.addAll(startLine.sublist(indexStart  , changeIndexStart +1 ));
                              } else{
                                sublist1=startLine.sublist(changeIndexStart, indexStart +1).reversed.toList();
                                route.addAll(sublist1);
                              }

                              if(changeIndexDestination < indexDestination){
                                route.addAll(destinationLine.sublist(changeIndexDestination, indexDestination +1));
                                direction= destinationLine.last;
                              } else{
                                sublist2=destinationLine.sublist(indexDestination, changeIndexDestination +1).reversed.toList();
                                route.addAll(sublist2);
                                direction=destinationLine[0];
                              }
                            } else{
                              if (indexStart < indexDestination){
                                route=startLine.sublist(indexStart, indexDestination +1);
                                direction= destinationLine.last;
                              }else{
                                sublist1=startLine.sublist(indexDestination, indexStart +1).reversed.toList();
                                route.addAll(sublist1);
                                direction=destinationLine[0];
                              }
                            }

                            route=route.toSet().toList();

                            //number of stations
                            numOfStations= route.length;

                            //time
                            time=numOfStations*2;
                            hours = (time / 60).toInt();
                            minutes = time % 60;

                            //ticket
                            if(numOfStations<=9){
                              ticket=8;
                            } else if(numOfStations >9 && numOfStations<=16){
                              ticket=10;
                            } else if(numOfStations >16 && numOfStations<=23){
                              ticket=15;
                            } else{
                              ticket=20;
                            }

                            Get.to(FindRoute() , arguments: {
                              'start' : start,
                              'destination' : destination,
                              'change station' : changeStation,
                              'route' : route,
                              'number of stations' : numOfStations,
                              'time' : time,
                              'hour' : hours,
                              'minute' : minutes,
                              'ticket' : ticket,
                              'direction' : direction,
                              'index destination' : indexDestination});
                          },
                              child: Text('Find Route'.tr,
                                style: TextStyle(
                                color: Colors.white,
                              ),
                              ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(80, 80)),
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
