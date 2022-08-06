import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ViewFlueGas extends StatefulWidget {
  const ViewFlueGas({Key? key}) : super(key: key);

  @override
  State<ViewFlueGas> createState() => _ViewFlueGasState();
}

class _ViewFlueGasState extends State<ViewFlueGas> {
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
          SizedBox(
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
                                backgroundColor: MaterialStateProperty.all<Color>(
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
                                backgroundColor: MaterialStateProperty.all<Color>(
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
          const SizedBox(height: 20),
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
                        height: h/1.6, //height of TabBarView
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.5))),
                        child: const TabBarView(children: <Widget>[
                          ViewFlueSteamBoiler(),
                          ViewFlueThermoPack(),
                        ]))
                  ])),
        ],
      ),
    );
  }
}

class ViewFlueSteamBoiler extends StatefulWidget {
  const ViewFlueSteamBoiler({Key? key}) : super(key: key);

  @override
  State<ViewFlueSteamBoiler> createState() => _ViewFlueSteamBoilerState();
}

class _ViewFlueSteamBoilerState extends State<ViewFlueSteamBoiler> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  // final item = titles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical:5, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Steam machine",
                                style: TextStyle(
                                    fontFamily: Constants.popins,
                                    color: Constants.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: w/3,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Value",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "0.5",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Temp",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "21",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Container(color: Constants.secondaryColor.withOpacity(0.2),width: 1,height: h/15,),
                              SizedBox(
                                  width: w/3,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Value %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "12 %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Temp %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "33 %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ViewFlueThermoPack extends StatefulWidget {
  const ViewFlueThermoPack({Key? key}) : super(key: key);

  @override
  State<ViewFlueThermoPack> createState() => _ViewFlueThermoPackState();
}

class _ViewFlueThermoPackState extends State<ViewFlueThermoPack> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  // final item = titles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical:5, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Thermo machine",
                                style: TextStyle(
                                    fontFamily: Constants.popins,
                                    color: Constants.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: w/3,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Value",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "0.5",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Temp",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "21",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Container(color: Constants.secondaryColor.withOpacity(0.2),width: 1,height: h/15,),
                              SizedBox(
                                  width: w/3,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Value %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "12 %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Temp %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "33 %",
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                decoration: TextDecoration.underline,
                                                // color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
