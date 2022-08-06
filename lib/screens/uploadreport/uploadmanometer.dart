import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class UploadManoMeter extends StatefulWidget {
  const UploadManoMeter({Key? key}) : super(key: key);

  @override
  State<UploadManoMeter> createState() => _UploadManoMeterState();
}

class _UploadManoMeterState extends State<UploadManoMeter> {
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
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(right: 15.0),
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Constants.primaryColor)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(" Sumbit  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Constants.popins,
                                  fontSize: 14)),
                          Image.asset(
                            "assets/icons/Edit.png",
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                          UploadManoSteam(),
                          UploadManoThermo(),
                        ]))
                  ])),
        ],
      ),
    );
  }
}

class UploadManoSteam extends StatefulWidget {
  const UploadManoSteam({Key? key}) : super(key: key);

  @override
  State<UploadManoSteam> createState() => _UploadManoSteamState();
}

class _UploadManoSteamState extends State<UploadManoSteam> {
  var stringListReturnedFromApiCall = [
    "Machine one",
    "Machine two",
    "Machine three",
    "Machine four",
    "Machine five",
  ];
  var ValueCallValue = ["0.02", "0.04", "0.23", "0.98", "0.47"];
  var TempCallValue = ["26", "21", "16", "11", "31"];

  List<TextEditingController> FlowControllers = [];
  List<TextEditingController> UnitControllers = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    ValueCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      FlowControllers.add(textEditingController);
    });
    TempCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      UnitControllers.add(textEditingController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
      children: [
          Container(
              width: w / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ID FAN(Hz)",
                        style: TextStyle(
                            fontFamily: Constants.popins,
                            // color: Constants.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 35,
                        width: w * 0.15,
                        child: TextField(
                          // controller: TDSControllers[index],
                          style: TextStyle(
                            fontFamily: Constants.popins,
                            // color: Constants.textColor,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.primaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: Constants.popins,
                              ),
                              // hintText: "first name",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "FD Fan(HZ)",
                        style: TextStyle(
                            fontFamily: Constants.popins,
                            // color: Constants.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 35,
                        width: w * 0.15,
                        child: TextField(
                          // controller: PHControllers[index],
                          style: TextStyle(
                            fontFamily: Constants.popins,
                            // color: Constants.textColor,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.primaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: Constants.popins,
                              ),
                              // hintText: "first name",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Coal",
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          Text(
                            "Used",
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 35,
                        width: w * 0.15,
                        child: TextField(
                          // controller: PHControllers[index],
                          style: TextStyle(
                            fontFamily: Constants.popins,
                            // color: Constants.textColor,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.primaryColor, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: Constants.popins,
                              ),
                              // hintText: "first name",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        Padding(
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
                  offset:
                  const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "APH TO FURNANCE",
                      style: TextStyle(
                          fontFamily: Constants.popins,
                          color: Constants.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                    width: w / 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Value",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  // color: Constants.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 35,
                              width: w * 0.25,
                              child: TextField(
                                // controller: FlowControllers[index],
                                style: TextStyle(
                                  fontFamily: Constants.popins,
                                  // color: Constants.textColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(
                                        bottom: 10.0, left: 10.0),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: Constants.popins,
                                    ),
                                    // hintText: "first name",
                                    fillColor: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Temp",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  // color: Constants.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 35,
                              width: w * 0.25,
                              child: TextField(
                                // controller: UnitControllers[index],
                                style: TextStyle(
                                  fontFamily: Constants.popins,
                                  // color: Constants.textColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(
                                        bottom: 10.0, left: 10.0),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Constants.primaryColor,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontFamily: Constants.popins,
                                    ),
                                    // hintText: "first name",
                                    fillColor: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: stringListReturnedFromApiCall.length,
            itemBuilder: (BuildContext context, int index) {
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
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stringListReturnedFromApiCall[index].toString(),
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: w / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Value",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 35,
                                    width: w * 0.25,
                                    child: TextField(
                                      controller: FlowControllers[index],
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.only(
                                              bottom: 10.0, left: 10.0),
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                                width: 2.0),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: Constants.popins,
                                          ),
                                          // hintText: "first name",
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Temp",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 35,
                                    width: w * 0.25,
                                    child: TextField(
                                      controller: UnitControllers[index],
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.only(
                                              bottom: 10.0, left: 10.0),
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                                width: 2.0),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: Constants.popins,
                                          ),
                                          // hintText: "first name",
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
        ));
  }
}

class UploadManoThermo extends StatefulWidget {
  const UploadManoThermo({Key? key}) : super(key: key);

  @override
  State<UploadManoThermo> createState() => _UploadManoThermoState();
}

class _UploadManoThermoState extends State<UploadManoThermo> {
  var stringListReturnedFromApiCall = [
    "Machine one",
    "Machine two",
    "Machine three",
    "Machine four",
    "Machine five",
  ];
  var ValueCallValue = ["0.02", "0.04", "0.23", "0.98", "0.47"];
  var TempCallValue = ["26", "21", "16", "11", "31"];

  List<TextEditingController> FlowControllers = [];
  List<TextEditingController> UnitControllers = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    ValueCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      FlowControllers.add(textEditingController);
    });
    TempCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      UnitControllers.add(textEditingController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  width: w / 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID FAN(Hz)",
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 35,
                            width: w * 0.15,
                            child: TextField(
                              // controller: TDSControllers[index],
                              style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: Constants.popins,
                                  ),
                                  // hintText: "first name",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "FD Fan(HZ)",
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 35,
                            width: w * 0.15,
                            child: TextField(
                              // controller: PHControllers[index],
                              style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: Constants.popins,
                                  ),
                                  // hintText: "first name",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Coal",
                                style: TextStyle(
                                    fontFamily: Constants.popins,
                                    // color: Constants.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                              Text(
                                "Used",
                                style: TextStyle(
                                    fontFamily: Constants.popins,
                                    // color: Constants.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 35,
                            width: w * 0.15,
                            child: TextField(
                              // controller: PHControllers[index],
                              style: TextStyle(
                                fontFamily: Constants.popins,
                                // color: Constants.textColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(bottom: 10.0, left: 10.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: Constants.popins,
                                  ),
                                  // hintText: "first name",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
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
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "APH TO FURNANCE",
                            style: TextStyle(
                                fontFamily: Constants.popins,
                                color: Constants.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: w / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Value",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 35,
                                    width: w * 0.25,
                                    child: TextField(
                                      // controller: FlowControllers[index],
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.only(
                                              bottom: 10.0, left: 10.0),
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                                width: 2.0),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: Constants.popins,
                                          ),
                                          // hintText: "first name",
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Temp",
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 35,
                                    width: w * 0.25,
                                    child: TextField(
                                      // controller: UnitControllers[index],
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.only(
                                              bottom: 10.0, left: 10.0),
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Constants.primaryColor,
                                                width: 2.0),
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontFamily: Constants.popins,
                                          ),
                                          // hintText: "first name",
                                          fillColor: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stringListReturnedFromApiCall.length,
                  itemBuilder: (BuildContext context, int index) {
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
                              offset:
                              const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stringListReturnedFromApiCall[index].toString(),
                                  style: TextStyle(
                                      fontFamily: Constants.popins,
                                      color: Constants.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                                width: w / 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Value",
                                          style: TextStyle(
                                              fontFamily: Constants.popins,
                                              // color: Constants.textColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 35,
                                          width: w * 0.25,
                                          child: TextField(
                                            controller: FlowControllers[index],
                                            style: TextStyle(
                                              fontFamily: Constants.popins,
                                              // color: Constants.textColor,
                                            ),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 10.0, left: 10.0),
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey.shade300,
                                                      width: 1.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Constants.primaryColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontFamily: Constants.popins,
                                                ),
                                                // hintText: "first name",
                                                fillColor: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Temp",
                                          style: TextStyle(
                                              fontFamily: Constants.popins,
                                              // color: Constants.textColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 35,
                                          width: w * 0.25,
                                          child: TextField(
                                            controller: UnitControllers[index],
                                            style: TextStyle(
                                              fontFamily: Constants.popins,
                                              // color: Constants.textColor,
                                            ),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 10.0, left: 10.0),
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey.shade300,
                                                      width: 1.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Constants.primaryColor,
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                hintStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontFamily: Constants.popins,
                                                ),
                                                // hintText: "first name",
                                                fillColor: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
