import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class UploadGEB extends StatefulWidget {
  const UploadGEB({Key? key}) : super(key: key);

  @override
  State<UploadGEB> createState() => _UploadGEBState();
}

class _UploadGEBState extends State<UploadGEB> {
  DateTime selectedDate = DateTime.now();
  bool isLoad = false;
  var data;
  TextEditingController kwh = TextEditingController();
  TextEditingController kvarh = TextEditingController();
  TextEditingController kvah = TextEditingController();
  TextEditingController md = TextEditingController();
  TextEditingController turbine = TextEditingController();

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
        FetchUploadGEBList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUploadGEBList();
  }

  void FetchUploadGEBList() async {
    setState(() {
      isLoad = true;
    });

    final response = await http.post(
      Uri.parse(
          '${Constants.weblink}urglist/${selectedDate.toString().split(" ")[0]}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
      if (data.length == 0) {
        kwh.text = "";
        kvarh.text = "";
        kvah.text = "";
        md.text = "";
        turbine.text = "";
      } else {
        kwh.text = data[0]['kwh'].toString();
        kvarh.text = data[0]['kvarh'].toString();
        kvah.text = data[0]['kvah'].toString();
        md.text = data[0]['md'].toString();
        turbine.text = data[0]['turbine'].toString();
      }
      setState(() {
        isLoad = false;
      });
    } else {
      print(response.statusCode);
      print(response.body);
      setState(() {
        isLoad = false;
      });
      Constants.showtoast("Error Fetching Data.");
    }
  }

  void AddGEBList() async {
    final response = await http.post(
      Uri.parse('${Constants.weblink}urgadd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // "id": data[0]['id'].toString(),
        "date": selectedDate.toString().split(" ")[0],
        "kwh": kwh.text,
        "kvarh": kvarh.text,
        "kvah": kvah.text,
        "md": md.text,
        "turbine": turbine.text
      }),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      Constants.showtoast("Machine Updated!");
      FetchUploadGEBList();
    } else {
      print(response.statusCode);
      print(response.body);
      Constants.showtoast("Error Updating Data.");
    }
  }

  void UpdateGEBList() async {
    final response = await http.post(
      Uri.parse('${Constants.weblink}urgupdate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": data[0]['id'].toString(),
        "date": selectedDate.toString().split(" ")[0],
        "kwh": kwh.text,
        "kvarh": kvarh.text,
        "kvah": kvah.text,
        "md": md.text,
        "turbine": turbine.text
      }),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      Constants.showtoast("Machine Updated!");
      FetchUploadGEBList();
    } else {
      print(response.statusCode);
      print(response.body);
      Constants.showtoast("Error Updating Data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    var formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
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
                          onPressed: () {
                            setState(() {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                setState(() {
                                  isLoad = true;
                                });
                                if (data.length == 0) {
                                  AddGEBList();
                                } else {
                                  UpdateGEBList();
                                }
                              } else {
                                Constants.showtoast(
                                    "please fill all the fields");
                              }
                            });

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
              (isLoad == true)
                  ? SizedBox(
                height: 500,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "KWH",
                          style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 35,
                          width: w * 0.4,
                          child: TextField(
                            controller: kwh,
                            style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "KVARH",
                          style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 35,
                          width: w * 0.4,
                          child: TextField(
                            controller: kvarh,
                            style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "KVAH",
                          style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(

                          height: 35,
                          width: w * 0.4,
                          child: TextField(
                            controller: kvah,
                            style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MD",
                          style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 35,
                          width: w * 0.4,
                          child: TextField(
                            controller: md,
                            style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Turbine",
                          style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                              // fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 35,
                          width: w * 0.4,
                          child: TextField(
                            controller: turbine,
                            style: TextStyle(
                              fontFamily: Constants.popins,
                              // color: Constants.textColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10.0),
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
                    const SizedBox(height: 15),
                    Divider()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
