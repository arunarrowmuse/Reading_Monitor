import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class ThermoPackList extends StatefulWidget {
  const ThermoPackList({Key? key}) : super(key: key);

  @override
  State<ThermoPackList> createState() => _ThermoPackListState();
}

class _ThermoPackListState extends State<ThermoPackList> {
  TextEditingController _coal1 = TextEditingController();
  TextEditingController _coal1dv = TextEditingController();
  TextEditingController _ratecoal1 = TextEditingController();
  TextEditingController _coal2 = TextEditingController();
  TextEditingController _coal2dv = TextEditingController();
  TextEditingController _ratecoal2 = TextEditingController();
  TextEditingController _deltaT = TextEditingController();
  TextEditingController _deltaTdv = TextEditingController();
  TextEditingController _chamber = TextEditingController();
  TextEditingController _chamberdv = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var data;

  void addthermoMachineList() async {
    final response = await http.post(
      Uri.parse('${Constants.weblink}mltpadd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "coal1": _coal1.text,
        "coal1_dev": _coal1dv.text,
        "rate_of_coal1": _ratecoal1.text,
        "coal2": _coal2.text,
        "coal2_dev": _coal2dv.text,
        "rate_of_coal2": _ratecoal2.text,
        "delta_t1": _deltaT.text,
        "delta_t2": _deltaTdv.text,
        "chamber_cost1": _chamber.text,
        "chamber_cost2": _chamberdv.text,
      }),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      _coal1.clear();
      _coal1dv.clear();
      _ratecoal1.clear();
      _coal2.clear();
      _coal2dv.clear();
      _ratecoal2.clear();
      _deltaT.clear();
      _deltaTdv.clear();
      _chamber.clear();
      _chamberdv.clear();
      Constants.showtoast("Report Added!");
    } else {
      print(response.statusCode);
      print(response.body);
      Constants.showtoast("Error adding Report.");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    "Coal 1",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _coal1,
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
              const SizedBox(height: 10),
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
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _coal1dv,
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
              const SizedBox(height: 10),
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
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _ratecoal1,
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
              const SizedBox(height: 10),
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
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _coal2,
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
              const SizedBox(height: 10),
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
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _coal2dv,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rate of Coal 2",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _ratecoal2,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delta T",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _deltaT,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delta T %",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _deltaTdv,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chamber Cost",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _chamber,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chamber Cost %",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: TextFormField(
                      controller: _chamberdv,
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      addthermoMachineList();
                    } else {
                      Constants.showtoast("Please fill all the fields");
                    }
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Constants.primaryColor)),
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
