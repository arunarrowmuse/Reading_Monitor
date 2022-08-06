import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class SteamBoilerList extends StatefulWidget {
  const SteamBoilerList({Key? key}) : super(key: key);

  @override
  State<SteamBoilerList> createState() => _SteamBoilerListState();
}

class _SteamBoilerListState extends State<SteamBoilerList> {
  TextEditingController bfw = TextEditingController();
  TextEditingController temp = TextEditingController();
  TextEditingController bfwpr = TextEditingController();
  TextEditingController bfwtemppr = TextEditingController();
  TextEditingController coal1 = TextEditingController();
  TextEditingController coal1dv = TextEditingController();
  TextEditingController ratecoal1 = TextEditingController();
  TextEditingController coal2 = TextEditingController();
  TextEditingController coal2dv = TextEditingController();
  TextEditingController ratecoal2 = TextEditingController();
  TextEditingController steamcost = TextEditingController();
  TextEditingController steamcostpr = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var data;

  void addsteamMachineList() async {
    final response = await http.post(
      Uri.parse('${Constants.weblink}mlsbadd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "bfw1": bfw.text,
        "bfw2": temp.text,
        "coal1": bfwpr.text,
        "coal1_div": bfwtemppr.text,
        "rate_of_coal1": coal1.text,
        "coal2": coal1dv.text,
        "coal2_div": ratecoal1.text,
        "rate_of_coal2": coal2.text,
        "bfw_temperature1": coal2dv.text,
        "bfw_temperature2": ratecoal2.text,
        "steam_cost1": steamcost.text,
        "steam_cost2": steamcostpr.text,
      }),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      bfw.clear();
      temp.clear();
      bfwpr.clear();
      bfwtemppr.clear();
      coal1.clear();
      coal1dv.clear();
      ratecoal1.clear();
      coal2.clear();
      coal2dv.clear();
      ratecoal2.clear();
      steamcost.clear();
      steamcostpr.clear();
      Constants.showtoast("Report Added!");
    } else {
      print(response.statusCode);
      print(response.body);
      Constants.showtoast("Error adding Report.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BFW",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: bfw,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Temperature",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: temp,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "BFW %",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: bfwpr,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "BFW Temperatuee %",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: bfwtemppr,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Coal 1",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: coal1,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Coal 1 Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: coal1dv,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Rate of Coal 1",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: ratecoal1,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Coal 2",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: coal2,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Coal 2 Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: coal2dv,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Rate 0f Coal 2",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: ratecoal2,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Steam Cost",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: steamcost,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
                    "Steam Cost %",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: steamcostpr,
                      validator: (value) {
                        if (value == null || value.isEmpty) return '';
                        return null;
                      },
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      addsteamMachineList();
                    } else {
                      Constants.showtoast("Please fill all the fields");
                    }
                  });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Constants.primaryColor)),
                child: Text(
                  "           Save           ",
                  style: TextStyle(
                      fontFamily: Constants.popins,
                      // color: Constants.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
