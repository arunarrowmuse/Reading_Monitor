import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../constants.dart';

class ViewManoMeter extends StatefulWidget {
  const ViewManoMeter({Key? key}) : super(key: key);

  @override
  State<ViewManoMeter> createState() => _ViewManoMeterState();
}

class _ViewManoMeterState extends State<ViewManoMeter> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    var formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 40,
            // color: Constants.secondaryColor,
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Icon(Icons.calendar_month, color: Colors.white,),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            "assets/icons/calendar.png",
                            color: Constants.primaryColor,
                          )),
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: Center(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                                color: Constants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: Constants.popins),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            "assets/icons/down.png",
                            color: Constants.primaryColor,
                          )),
                      // Icon(Icons.l, color: Colors.white,),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        // width: 100,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFE1DFDD))),
                            child: Text(" SMS ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: Constants.popins,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        // width: 100,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFE1DFDD))),
                            child: Text(" E-Mail ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: Constants.popins,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20),
          DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      color: Constants.primaryColor,
                      child: TabBar(
                        indicatorColor: Colors.red,
                        // labelColor: Colors.green,
                        // unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text(
                              "Steam Boiler",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Thermopack",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: h / 1.5, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          ViewManoSteam(),
                          ViewManoThermo(),
                        ]))
                  ])),
        ],
      ),
    );
  }
}

class ViewManoSteam extends StatefulWidget {
  const ViewManoSteam({Key? key}) : super(key: key);

  @override
  State<ViewManoSteam> createState() => _ViewManoSteamState();
}

class _ViewManoSteamState extends State<ViewManoSteam> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: w / 3.2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "ID FAN(Hz)",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "FD FAN(Hz)",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "COAL USED",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: w / 3.2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "41 Hz",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "24 Hz",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "4000 GAR",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: w / 2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "APH TO FURNANCE",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 5,
                child: Center(
                  child: Text(
                    "35",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 4.2,
                child: Center(
                  child: Text(
                    "65 C",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      // Transform.rotate(
                      //   child: Center(
                      //     child: Text(
                      //       "<<",
                      //       style: TextStyle(fontSize: 40),
                      //     ),
                      //   ),
                      //   angle: -math.pi/2,
                      // ),
                      // Center(
                      //   child: Container(
                      //     width: 5,
                      //     height: 60,
                      //     color: Constants.secondaryColor, //Text
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius:  2,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "Steam Boiler",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        color: Constants.textColor,
                                        // fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  // SizedBox(height: 10),
                                  // Container(color: Colors.blue,width: w,height: 1,),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Value"),
                                      Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                            color: Colors.grey.shade200,
                                            border: Border.all(
                                                color: Constants.primaryColor)),
                                        child: Center(
                                          child: Text("30"),
                                        ),
                                      ),
                                      Container(
                                        color: Constants.secondaryColor
                                            .withOpacity(0.2),
                                        width: 1,
                                        height: h / 15,
                                      ),
                                      Text("Temp"),
                                      Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                            color: Colors.grey.shade200,
                                            border: Border.all(
                                                color: Constants.primaryColor)),
                                        child: Center(
                                          child: Text("65 C"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ); // todo change here!
                }),
          ),
        ],
      ),
    );
  }
}

class ViewManoThermo extends StatefulWidget {
  const ViewManoThermo({Key? key}) : super(key: key);

  @override
  State<ViewManoThermo> createState() => _ViewManoThermoState();
}

class _ViewManoThermoState extends State<ViewManoThermo> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: w / 3.2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "ID FAN(Hz)",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "FD FAN(Hz)",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "COAL USED",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: w / 3.2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "41 Hz",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "24 Hz",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 3.2,
                child: Center(
                  child: Text(
                    "4000 GAR",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: w / 2,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Text(
                    "APH TO FURNANCE",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 5,
                child: Center(
                  child: Text(
                    "35",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey)),
                width: w / 4.2,
                child: Center(
                  child: Text(
                    "65 C",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 14,
                      fontFamily: Constants.popins,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      // Transform.rotate(
                      //   child: Center(
                      //     child: Text(
                      //       "<<",
                      //       style: TextStyle(fontSize: 40),
                      //     ),
                      //   ),
                      //   angle: -math.pi/2,
                      // ),
                      // Center(
                      //   child: Container(
                      //     width: 5,
                      //     height: 60,
                      //     color: Constants.secondaryColor, //Text
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 25),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius:  2,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "Steam Boiler",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        color: Constants.textColor,
                                        // fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  // SizedBox(height: 10),
                                  // Container(color: Colors.blue,width: w,height: 1,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Value"),
                                      Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                            color: Colors.grey.shade200,
                                            border: Border.all(
                                                color: Constants.primaryColor)),
                                        child: Center(
                                          child: Text("30"),
                                        ),
                                      ),
                                      Container(
                                        color: Constants.secondaryColor
                                            .withOpacity(0.2),
                                        width: 1,
                                        height: h / 15,
                                      ),
                                      Text("Temp"),
                                      Container(
                                        height: 35,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(12)),
                                            color: Colors.grey.shade200,
                                            border: Border.all(
                                                color: Constants.primaryColor)),
                                        child: Center(
                                          child: Text("65 C"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ); // todo change here!
                }),
          ),

        ],
      ),
    );
  }
}


