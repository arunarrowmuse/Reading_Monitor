  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class UploadUtility extends StatefulWidget {
  const UploadUtility({Key? key}) : super(key: key);

  @override
  State<UploadUtility> createState() => _UploadUtilityState();
}

class _UploadUtilityState extends State<UploadUtility> {
  var stringListReturnedFromApiCall = [
    "Machine one",
    "Machine two",
    "Machine three",
    "Machine four",
    "Machine five",
  ];
  var EMCallValue = ["0.0234", "0.04", "0.23", "0.98", "0.47"];
  var HMCallValue = ["26", "21", "16", "11", "31"];

  List<TextEditingController> EMControllers = [];
  List<TextEditingController> HMControllers = [];

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
  void initState() {
    super.initState();
    EMCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      EMControllers.add(textEditingController);
    });
    HMCallValue.forEach((String str) {
      var textEditingController = TextEditingController(text: str);
      HMControllers.add(textEditingController);
    });
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
          const SizedBox(height: 20),
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
                        const SizedBox(height: 10),
                        SizedBox(
                            width: w / 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "EM",
                                      style: TextStyle(
                                          fontFamily: Constants.popins,
                                          // color: Constants.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      height: 35,
                                      width: w * 0.25,
                                      child: TextField(
                                        controller: EMControllers[index],
                                        style: TextStyle(
                                            fontFamily: Constants.popins,
                                            fontSize: 14
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
                                      "HM",
                                      style: TextStyle(
                                          fontFamily: Constants.popins,
                                          // color: Constants.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      height: 35,
                                      width: w * 0.25,
                                      child: TextField(
                                        controller: HMControllers[index],
                                        style: TextStyle(
                                          fontSize: 14,
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
    );
  }
}
