import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ViewMisc extends StatefulWidget {
  const ViewMisc({Key? key}) : super(key: key);

  @override
  State<ViewMisc> createState() => _ViewMiscState();
}

class _ViewMiscState extends State<ViewMisc> {

  List data = [
    "waste pump",
    "Oxygen pump",
    "supply pump 1",
    "water pump",
    "air pump",
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
                        vertical: 10, horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index],
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  color: Constants.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Unit",
                                  style: TextStyle(
                                      fontFamily: Constants.popins,
                                      fontSize: 12),
                                ),
                                SizedBox(width: 30),
                                Text(
                                  "34 ATM",
                                  style: TextStyle(
                                      decoration:  TextDecoration.underline,
                                      fontFamily: Constants.popins,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            Container(color: Colors.black,height: 20,width: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deviation",
                                  style: TextStyle(
                                      fontFamily: Constants.popins,
                                      fontSize: 12),
                                ),
                                SizedBox(width: 30),
                                Text(
                                  "0.9 %",
                                  style: TextStyle(
                                      decoration:  TextDecoration.underline,
                                      fontFamily: Constants.popins,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Container(color: Colors.blue,width: w,height: 1,),
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