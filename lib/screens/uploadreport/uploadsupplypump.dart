import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class UploadSupplyPump extends StatefulWidget {
  const UploadSupplyPump({Key? key}) : super(key: key);

  @override
  State<UploadSupplyPump> createState() => _UploadSupplyPumpState();
}

class _UploadSupplyPumpState extends State<UploadSupplyPump> {
  List<TextEditingController> FlowControllers = [];
  List<TextEditingController> UnitControllers = [];
  List<TextEditingController> ValueID = [];
  DateTime selectedDate = DateTime.now();
  bool isLoad = false;
  var data;
  var listdata;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate.toString().split(" ")[0]);
        FlowControllers.clear();
        UnitControllers.clear();
        FetchSupplyList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FetchSupplyList();
  }

  void FetchSupplyList() async {
    setState(() {
      isLoad = true;
    });
    final response = await http.post(
      Uri.parse('${Constants.weblink}spilist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      listdata = jsonDecode(response.body);
      print("machine list");
      print(listdata.length);
      print(listdata);
      final responses = await http.post(
        Uri.parse(
            '${Constants.weblink}ursplist/${selectedDate.toString().split(" ")[0]}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (responses.statusCode == 200) {
        data = jsonDecode(responses.body);
        print(" upload data");
        print(data.length);
        print(data);
        if (data.length == 0) {
          for (int i = 0; i < listdata.length; i++) {
            var flowController = TextEditingController(text: "");
            var unitController = TextEditingController(text: "");
            FlowControllers.add(flowController);
            UnitControllers.add(unitController);
          }
        } else {
          for (int i = 0; i < data.length; i++) {
            var idController =
                TextEditingController(text: data[i]['id'].toString());
            var flowController =
                TextEditingController(text: data[i]['flow'].toString());
            var unitController =
                TextEditingController(text: data[i]['units'].toString());
            ValueID.add(idController);
            FlowControllers.add(flowController);
            UnitControllers.add(unitController);
          }
        }
        setState(() {
          isLoad = false;
        });
      } else {
        print(responses.statusCode);
        print(responses.body);
        setState(() {
          isLoad = false;
        });
        Constants.showtoast("Error Fetching Data.");
      }
    } else {
      Constants.showtoast("Error Fetching Data.");
    }
  }

  void AddSupplyList() async {
    for (int i = 0; i < listdata.length; i++) {
      final response = await http.post(
        Uri.parse('${Constants.weblink}urspadd'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          // "id": ValueID[i].text,
          "date": selectedDate.toString().split(" ")[0],
          "machine_name_id": listdata[i]["id"].toString(),
          "flow": FlowControllers[i].text,
          "units": UnitControllers[i].text
        }),
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Added!");
        }
        // Constants.showtoast("Report Updated!");
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
      }
    }
    FetchSupplyList();
  }

  void UpdateSupplyList() async {
    for (int i = 0; i < listdata.length; i++) {
      final response = await http.post(
        Uri.parse('${Constants.weblink}urspupdate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": ValueID[i].text,
          "date": selectedDate.toString().split(" ")[0],
          "machine_name_id": listdata[i]["id"].toString(),
          "flow": FlowControllers[i].text,
          "units": UnitControllers[i].text
        }),
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Updated!");
        }
        // Constants.showtoast("Report Updated!");
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
      }
    }
    FetchSupplyList();
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
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(right: 15.0),
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        if (data.length == 0) {
                          AddSupplyList();
                        } else {
                          UpdateSupplyList();
                        }
                      },
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
          SizedBox(height: 20),
          (isLoad == true)
              ? SizedBox(
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Constants.primaryColor,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: listdata.length,
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listdata[index]['machine'],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Flow",
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
                                              controller:
                                                  FlowControllers[index],
                                              style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                              ),
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0,
                                                          left: 10.0),
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Constants
                                                            .primaryColor,
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontFamily:
                                                        Constants.popins,
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
                                            "Unit",
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
                                              controller:
                                                  UnitControllers[index],
                                              style: TextStyle(
                                                fontFamily: Constants.popins,
                                                // color: Constants.textColor,
                                              ),
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0,
                                                          left: 10.0),
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Constants
                                                            .primaryColor,
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontFamily:
                                                        Constants.popins,
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
    );
  }
}