import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class UploadManoMeter extends StatefulWidget {
  const UploadManoMeter({Key? key}) : super(key: key);

  @override
  State<UploadManoMeter> createState() => _UploadManoMeterState();
}

class _UploadManoMeterState extends State<UploadManoMeter> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 10),
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
      ),
    );
  }
}

class UploadManoSteam extends StatefulWidget {
  const UploadManoSteam({Key? key}) : super(key: key);

  @override
  State<UploadManoSteam> createState() => _UploadManoSteamState();
}

class _UploadManoSteamState extends State<UploadManoSteam>
    with AutomaticKeepAliveClientMixin<UploadManoSteam> {
  List<TextEditingController> ValueControllers = [];
  List<TextEditingController> TempControllers = [];
  List<TextEditingController> ValueID = [];
  TextEditingController idfan = TextEditingController();
  TextEditingController fdfan = TextEditingController();
  TextEditingController coalused = TextEditingController();
  TextEditingController aphvalue = TextEditingController();
  TextEditingController aphtemp = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isLoad = false;
  var data;
  var listdata;
  late SharedPreferences prefs;
  String? tokenvalue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050, 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ValueControllers.clear();
        TempControllers.clear();
        idfan.clear();
        fdfan.clear();
        coalused.clear();
        aphvalue.clear();
        aphtemp.clear();
        FetchManoSteamList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FetchManoSteamList();
  }

  void FetchManoSteamList() async {
    setState(() {
      isLoad = true;
    });
    prefs = await SharedPreferences.getInstance();
    tokenvalue = prefs.getString("token");
    final response = await http.get(
      Uri.parse('${Constants.weblink}ManoMeterSteamBoilerLisiting'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $tokenvalue',
      },
    );
    print(response.statusCode);
    print(response.statusCode);
    if (response.statusCode == 200) {
      listdata = jsonDecode(response.body);
      print("machine list");
      print(listdata.length);
      print(listdata);
      final responses = await http.get(
        Uri.parse(
            '${Constants.weblink}ManoMeterSteamBoilerReportUploadSharch/${selectedDate.toString().split(" ")[0]}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
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
            ValueControllers.add(flowController);
            TempControllers.add(unitController);
          }
        } else {
          for (int i = 0; i < data.length; i++) {
            var idController =
                TextEditingController(text: data[i]['id'].toString());
            var valueController =
                TextEditingController(text: data[i]['value'].toString());
            var tempController =
                TextEditingController(text: data[i]['temperature'].toString());
            ValueID.add(idController);
            ValueControllers.add(valueController);
            TempControllers.add(tempController);
            idfan.text = data[i]['id_fan'].toString();
            fdfan.text = data[i]['fd_fan'].toString();
            coalused.text = data[i]['coal_used'].toString();
            aphvalue.text = data[i]['aph_value'].toString();
            aphtemp.text = data[i]['aph_temperature'].toString();
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
        // print("erro here1");
        // Constants.showtoast("Error Fetching Data.");
      }
    } else {
      print("erro here2");
      Constants.showtoast("Error Fetching Data.");
    }
  }

  void AddManoSteamList() async {
    for (int i = 0; i < listdata.length; i++) {
      String value = "0";
      String temp = "0";
      String id = "0";
      String fd = "0";
      String coal = "0";
      String aphvaluee = "0";
      String aphtempp = "0";
      if (ValueControllers[i].text != "") {
        value = ValueControllers[i].text;
      }
      if (TempControllers[i].text != "") {
        temp = TempControllers[i].text;
      }
      if (idfan.text != "") {
        id = idfan.text;
      }
      if (fdfan.text != "") {
        fd = fdfan.text;
      }
      if (coalused.text != "") {
        coal = coalused.text;
      }
      if (aphvalue.text != "") {
        aphvaluee = aphvalue.text;
      }
      if (aphtemp.text != "") {
        aphtempp = aphtemp.text;
      }
      final response = await http.post(
        Uri.parse('${Constants.weblink}ManoMeterSteamBoilerReportUploadAdd'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
        },
        body: jsonEncode(<String, String>{
          "date": selectedDate.toString().split(" ")[0],
          "machine_id": listdata[i]["id"].toString(),
          "id_fan": id,
          "fd_fan": fd,
          "coal_used": coal,
          "aph_value": aphvaluee,
          "aph_temperature": aphtempp,
          "value": value,
          "temperature": temp
        }),
      );
      if (response.statusCode == 200) {
        // data = jsonDecode(response.body);
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Added!");
          Utils(context).stopLoading();
        }
        // Constants.showtoast("Report Updated!");
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
        Utils(context).stopLoading();
      }
    }
    FetchManoSteamList();
  }

  void UpdateManoSteamList() async {
    for (int i = 0; i < listdata.length; i++) {
      String value = "0";
      String temp = "0";
      String id = "0";
      String fd = "0";
      String coal = "0";
      String aphvaluee = "0";
      String aphtempp = "0";
      if (ValueControllers[i].text != "") {
        value = ValueControllers[i].text;
      }
      if (TempControllers[i].text != "") {
        temp = TempControllers[i].text;
      }
      if (idfan.text != "") {
        id = idfan.text;
      }
      if (fdfan.text != "") {
        fd = fdfan.text;
      }
      if (coalused.text != "") {
        coal = coalused.text;
      }
      if (aphvalue.text != "") {
        aphvaluee = aphvalue.text;
      }
      if (aphtemp.text != "") {
        aphtempp = aphtemp.text;
      }
      final response = await http.put(
        Uri.parse(
            '${Constants.weblink}ManoMeterSteamBoilerReportUploadUpdate/${data[i]['id']}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
        },
        body: jsonEncode(<String, String>{
          "id_fan": id,
          "fd_fan": fd,
          "coal_used": coal,
          "aph_value": aphvaluee,
          "aph_temperature": aphtempp,
          "value": value,
          "temperature": temp
        }),
      );
      if (response.statusCode == 200) {
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Updated!");
          Utils(context).stopLoading();
        }
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
        Utils(context).stopLoading();
      }
    }
    FetchManoSteamList();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    var formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    return RefreshIndicator(
      onRefresh: () {
        return Future(() => FetchManoSteamList());
      },
      child: Scaffold(
          body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              Utils(context).startLoading();
                              if (data.length == 0) {
                                AddManoSteamList();
                              } else {
                                UpdateManoSteamList();
                              }
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
              const SizedBox(height: 10),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: idfan,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: fdfan,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: coalused,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: aphvalue,
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: aphtemp,
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
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
              (isLoad == true)
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      ),
                    )
                  : (listdata.length == 0)
                      ? Container(
                          height: 200,
                          child: Center(
                            child: Text(
                              "no machines found",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  color: Constants.textColor,
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: listdata.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(ValueControllers[index]);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                      vertical: 5, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listdata[index]['steam_boiler']
                                                .toString(),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Value",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    height: 35,
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,

                                                      controller:
                                                          ValueControllers[
                                                              index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      left:
                                                                          10.0),
                                                              isDense: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    Constants
                                                                        .popins,
                                                              ),
                                                              // hintText: "first name",
                                                              fillColor: Colors
                                                                  .white70),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Temp",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    height: 35,
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,

                                                      controller:
                                                          TempControllers[
                                                              index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      left:
                                                                          10.0),
                                                              isDense: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    Constants
                                                                        .popins,
                                                              ),
                                                              // hintText: "first name",
                                                              fillColor: Colors
                                                                  .white70),
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
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UploadManoThermo extends StatefulWidget {
  const UploadManoThermo({Key? key}) : super(key: key);

  @override
  State<UploadManoThermo> createState() => _UploadManoThermoState();
}

class _UploadManoThermoState extends State<UploadManoThermo>
    with AutomaticKeepAliveClientMixin<UploadManoThermo> {
  List<TextEditingController> ValueControllers = [];
  List<TextEditingController> TempControllers = [];
  List<TextEditingController> ValueID = [];
  TextEditingController idfan = TextEditingController();
  TextEditingController fdfan = TextEditingController();
  TextEditingController coalused = TextEditingController();
  TextEditingController aphvalue = TextEditingController();
  TextEditingController aphtemp = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isLoad = false;
  var data;
  var listdata;
  late SharedPreferences prefs;
  String? tokenvalue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050, 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ValueControllers.clear();
        TempControllers.clear();
        idfan.clear();
        fdfan.clear();
        coalused.clear();
        aphvalue.clear();
        aphtemp.clear();
        FetchManoThermoList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FetchManoThermoList();
  }

  void FetchManoThermoList() async {
    setState(() {
      isLoad = true;
    });
    prefs = await SharedPreferences.getInstance();
    tokenvalue = prefs.getString("token");
    final response = await http.get(
      Uri.parse('${Constants.weblink}ManoMeterThermopackLisiting'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $tokenvalue',
      },
    );
    if (response.statusCode == 200) {
      listdata = jsonDecode(response.body);
      print("machine list");
      print(listdata.length);
      print(listdata);
      final responses = await http.get(
        Uri.parse(
            '${Constants.weblink}ManoMeterThermopackReportUploadSharch/${selectedDate.toString().split(" ")[0]}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
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
            ValueControllers.add(flowController);
            TempControllers.add(unitController);
          }
        } else {
          for (int i = 0; i < data.length; i++) {
            var idController =
                TextEditingController(text: data[i]['id'].toString());
            var valueController =
                TextEditingController(text: data[i]['value'].toString());
            var tempController =
                TextEditingController(text: data[i]['temperature'].toString());
            ValueID.add(idController);
            ValueControllers.add(valueController);
            TempControllers.add(tempController);
            idfan.text = data[i]['id_fan'].toString();
            fdfan.text = data[i]['fd_fan'].toString();
            coalused.text = data[i]['coal_used'].toString();
            aphvalue.text = data[i]['aph_value'].toString();
            aphtemp.text = data[i]['aph_temperature'].toString();
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

  void AddManoThermoList() async {
    for (int i = 0; i < listdata.length; i++) {
      String value = "0";
      String temp = "0";
      String id = "0";
      String fd = "0";
      String coal = "0";
      String aphvaluee = "0";
      String aphtempp = "0";
      if (ValueControllers[i].text != "") {
        value = ValueControllers[i].text;
      }
      if (TempControllers[i].text != "") {
        temp = TempControllers[i].text;
      }
      if (idfan.text != "") {
        id = idfan.text;
      }
      if (fdfan.text != "") {
        fd = fdfan.text;
      }
      if (coalused.text != "") {
        coal = coalused.text;
      }
      if (aphvalue.text != "") {
        aphvaluee = aphvalue.text;
      }
      if (aphtemp.text != "") {
        aphtempp = aphtemp.text;
      }
      final response = await http.post(
        Uri.parse('${Constants.weblink}ManoMeterThermopackReportUploadAdd'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
        },
        body: jsonEncode(<String, String>{
          "date": selectedDate.toString().split(" ")[0],
          "machine_id": listdata[i]["id"].toString(),
          "id_fan": id,
          "fd_fan": fd,
          "coal_used": coal,
          "aph_value": aphvaluee,
          "aph_temperature": aphtempp,
          "value": value,
          "temperature": temp,
        }),
      );
      if (response.statusCode == 200) {
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Added!");
          Utils(context).stopLoading();
        }
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
        Utils(context).stopLoading();
      }
    }
    FetchManoThermoList();
  }

  void UpdateManoThermoList() async {
    for (int i = 0; i < listdata.length; i++) {
      String value = "0";
      String temp = "0";
      String id = "0";
      String fd = "0";
      String coal = "0";
      String aphvaluee = "0";
      String aphtempp = "0";
      if (ValueControllers[i].text != "") {
        value = ValueControllers[i].text;
      }
      if (TempControllers[i].text != "") {
        temp = TempControllers[i].text;
      }
      if (idfan.text != "") {
        id = idfan.text;
      }
      if (fdfan.text != "") {
        fd = fdfan.text;
      }
      if (coalused.text != "") {
        coal = coalused.text;
      }
      if (aphvalue.text != "") {
        aphvaluee = aphvalue.text;
      }
      if (aphtemp.text != "") {
        aphtempp = aphtemp.text;
      }
      final response = await http.put(
        Uri.parse(
            '${Constants.weblink}ManoMeterThermopackReportUploadUpdate/${data[i]['id']}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenvalue',
        },
        body: jsonEncode(<String, String>{
          // "date": selectedDate.toString().split(" ")[0],
          // "machine_id": listdata[i]["id"].toString(),
          "id_fan": id,
          "fd_fan": fd,
          "coal_used": coal,
          "aph_value": aphvaluee,
          "aph_temperature": aphtempp,
          "value": value,
          "temperature": temp
        }),
      );
      if (response.statusCode == 200) {
        if (i == listdata.length - 1) {
          Constants.showtoast("Report Updated!");
          Utils(context).stopLoading();
        }
      } else {
        print(response.statusCode);
        print(response.body);
        Constants.showtoast("Error Updating Data.");
        Utils(context).stopLoading();
      }
    }
    FetchManoThermoList();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    var formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    return RefreshIndicator(
      onRefresh: () {
        return Future(() => FetchManoThermoList());
      },
      child: Scaffold(
          body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              Utils(context).startLoading();
                              if (data.length == 0) {
                                AddManoThermoList();
                              } else {
                                UpdateManoThermoList();
                              }
                            } else {
                              Constants.showtoast("Please Fill all the fields");
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
              const SizedBox(height: 10),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,

                              controller: idfan,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,

                              controller: fdfan,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: coalused,
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
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 2.0),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: aphvalue,
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: aphtemp,
                                      style: TextStyle(
                                        fontFamily: Constants.popins,
                                        // color: Constants.textColor,
                                      ),
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
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
              (isLoad == true)
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      ),
                    )
                  : (listdata.length == 0)
                      ? Container(
                          height: 200,
                          child: Center(
                            child: Text(
                              "no machines found",
                              style: TextStyle(
                                  fontFamily: Constants.popins,
                                  color: Constants.textColor,
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: listdata.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(ValueControllers[index]);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                      vertical: 5, horizontal: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listdata[index]['thermopack']
                                                .toString(),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Value",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    height: 35,
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          ValueControllers[
                                                              index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      left:
                                                                          10.0),
                                                              isDense: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    Constants
                                                                        .popins,
                                                              ),
                                                              // hintText: "first name",
                                                              fillColor: Colors
                                                                  .white70),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Temp",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    height: 35,
                                                    width: w * 0.25,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          TempControllers[
                                                              index],
                                                      style: TextStyle(
                                                        fontFamily:
                                                            Constants.popins,
                                                        // color: Constants.textColor,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      left:
                                                                          10.0),
                                                              isDense: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width: 1.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Constants
                                                                        .primaryColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .grey[400],
                                                                fontFamily:
                                                                    Constants
                                                                        .popins,
                                                              ),
                                                              // hintText: "first name",
                                                              fillColor: Colors
                                                                  .white70),
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
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
