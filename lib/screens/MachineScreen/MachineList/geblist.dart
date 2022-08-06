import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class GEBList extends StatefulWidget {
  const GEBList({Key? key}) : super(key: key);

  @override
  State<GEBList> createState() => _GEBListState();
}

class _GEBListState extends State<GEBList> {
  final TextEditingController _kwh = TextEditingController();
  final TextEditingController _dev_kwh = TextEditingController();
  final TextEditingController _kvarh = TextEditingController();
  final TextEditingController _dev_kvarh = TextEditingController();
  final TextEditingController _kvah = TextEditingController();
  final TextEditingController _dev_kvah = TextEditingController();
  final TextEditingController _pf = TextEditingController();
  final TextEditingController _dev_pf = TextEditingController();
  final TextEditingController _md = TextEditingController();
  final TextEditingController _dev_md = TextEditingController();
  final TextEditingController _tb = TextEditingController();
  final TextEditingController _dev_tb = TextEditingController();
  final TextEditingController _mf = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var data;

  void addGEBMachineList(
    String kwh,
    String devKwh,
    String kvarh,
    String devKvarh,
    String kvah,
    String devKvah,
    String pf,
    String devPf,
    String md,
    String devMd,
    String tb,
    String devTb,
    String mf,
  ) async {
    final response = await http.post(
      Uri.parse('${Constants.weblink}gebadd'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "kwh": kwh,
        "dev_kwh": devKwh,
        "kvarh": kvarh,
        "dev_kvarh": devKvarh,
        "kvah": kvah,
        "dev_kvah": devKvah,
        "pf": pf,
        "dev_pf": devPf,
        "md": md,
        "dev_md": devMd,
        "tb": tb,
        "dev_tb": devTb,
        "mf": mf,
      }),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      _kwh.clear();
      _dev_kwh.clear();
      _kvarh.clear();
      _dev_kvarh.clear();
      _kvah.clear();
      _dev_kvah.clear();
      _pf.clear();
      _dev_pf.clear();
      _md.clear();
      _dev_md.clear();
      _tb.clear();
      _dev_tb.clear();
      _mf.clear();
      Constants.showtoast("Report Added!");
    } else {
      print(response.statusCode);
      print(response.body);
      Constants.showtoast("Error adding Report.");
    }
  }

  @override
  Widget build(BuildContext context) {
    //    final h = MediaQuery.of(context).size.height;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "KWH",
                    style:
                        TextStyle(fontFamily: Constants.popins, fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _kwh,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "KWH Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_kwh,
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
                  ),
                ],
              ),
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
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _kvarh,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "KVARH Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_kvarh,
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
                  ),
                ],
              ),
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
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _kvah,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "KVAH Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_kvah,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PF",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _pf,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PF Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_pf,
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
                  ),
                ],
              ),
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
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _md,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MD Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_md,
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
                  ),
                ],
              ),
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
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _tb,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Turbine Deviation",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _dev_tb,
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MF",
                    style: TextStyle(
                        fontFamily: Constants.popins,
                        // color: Constants.textColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 45,
                    width: w * 0.4,
                    child: Center(
                      child: TextFormField(
                        controller: _mf,
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
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();

                      addGEBMachineList(
                          _kwh.text,
                          _dev_kwh.text,
                          _kvarh.text,
                          _dev_kvarh.text,
                          _kvah.text,
                          _dev_kvah.text,
                          _pf.text,
                          _dev_pf.text,
                          _md.text,
                          _dev_md.text,
                          _tb.text,
                          _dev_tb.text,
                          _mf.text);
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
