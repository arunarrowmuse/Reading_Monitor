import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class ViewSteamBoiler extends StatefulWidget {
  const ViewSteamBoiler({Key? key}) : super(key: key);

  @override
  State<ViewSteamBoiler> createState() => _ViewSteamBoilerState();
}

class _ViewSteamBoilerState extends State<ViewSteamBoiler> {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" BFW :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("23.56",
                            style: TextStyle(
                                // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" BFW % :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("2.3",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Coal 1 :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("65",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Coal 2 :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("49",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Rate of Coal 1 :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("12.11",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Steam Cost :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("4.68",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" BFW Temperature :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("73.02",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" BFW Temperature % :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("3.00",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Coal 1 Deviation :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("0.04",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Coal 2 Deviation :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("0.08",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Rate of Coal 2 :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("18.77",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Steam Cost % :",
                        style: TextStyle(
                            // color: Colors.grey,
                            fontFamily: Constants.popins,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text("2.05",
                            style: TextStyle(
                              // color: Colors.grey,
                                fontFamily: Constants.popins,
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
