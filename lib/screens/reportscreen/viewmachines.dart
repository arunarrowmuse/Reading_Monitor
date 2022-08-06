import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class VIewMachines extends StatefulWidget {
  const VIewMachines({Key? key}) : super(key: key);

  @override
  State<VIewMachines> createState() => _VIewMachinesState();
}

class _VIewMachinesState extends State<VIewMachines> {
  List data = [
    "machine 1",
    "machine 2",
    "machine 5",
    "machine 4",
    "machine 3",
    "machine 3",
    "machine 3",
  ];

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
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // final item = titles[index];
                return (index == 0 || index == 3)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.secondaryColor,
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
                              vertical: 10, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index],
                                    style: TextStyle(
                                        fontFamily: Constants.popins,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.w600,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Container(color: Colors.blue,width: w,height: 1,),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: w / 2.5,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "EM",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "0.5",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "HM",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "21",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "EM/HM",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "0.07",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "%",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "0.07",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                    color: Colors.white,
                                    width: 1,
                                    height: h / 15,
                                  ),
                                  Container(
                                      width: w / 2.5,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Water",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "122",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Batch",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "33",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Water/Batch",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "544654",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    // fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "%",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    color: Colors.white,
                                                    // color: Constants.textColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "4600",
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constants.popins,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
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
                      )
                    : Stack(
                        children: [
                          Positioned(
                            top: -20,
                            // bottom: 100,
                            left: 30,
                            child: Container(
                              width: 5,
                              height: 60,
                              color: Constants.secondaryColor, //Text
                            ),
                          ),
                          Positioned(
                            top: -20,
                            // bottom: 100,
                            right: 30,
                            child: Container(
                              width: 5,
                              height: 60,
                              color: Constants.secondaryColor, //Text
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15.0)),
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
                                      vertical: 10, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index],
                                            style: TextStyle(
                                                fontFamily: Constants.popins,
                                                color: Constants.textColor,
                                                // fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      // Container(color: Colors.blue,width: w,height: 1,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: w / 2.5,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "EM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "0.5",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "HM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "21",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "EM/HM",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "0.07",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "%",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "0.07",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            color: Constants.secondaryColor
                                                .withOpacity(0.2),
                                            width: 1,
                                            height: h / 15,
                                          ),
                                          Container(
                                              width: w / 2.5,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Water",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "122",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Batch",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "33",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Water/Batch",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "544654",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "%",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            // color: Constants.textColor,
                                                            // fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        "4600",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Constants.popins,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
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
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
