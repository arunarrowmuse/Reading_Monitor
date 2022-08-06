import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../MachineScreen/MachineList/mainmachinelist.dart';
import '../MachineScreen/machinecomp.dart';
import '../auth/adduser.dart';
import '../auth/login_screen.dart';
import '../auth/switchuser.dart';
import '../charts.dart';
import '../meterReading/meter_reading.dart';
import '../profile/profilepage.dart';
import '../reportscreen/report_tabs.dart';
import '../reportscreen/viewreport.dart';
import '../todo.dart';
import '../uploadreport/uploadreport.dart';
import 'Drawer/drawerBody.dart';
import 'mainscreen.dart';

class Switcher extends StatefulWidget {
  int values;

  Switcher({Key? key, required this.values}) : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  late int currentpage;

  List getPages = [
    const MainScreen(),
    const ViewReport(),
    const UploadReport(),
    const MachineComparison(),
    const Charts(),
    const MainMachineList(),
    const MainMachineList(),
    const MeterReading(),
    const ProfilePage(),
    const ToDo(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentpage = widget.values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        child: getPages[currentpage],
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(
            'assets/images/RmLogo.png',
            // height: 64,
            // width: 302,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            color: const Color(0xFF6EB7A1),
            // color: Constants.primaryColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.add_circle, color: Colors.white),
                      Text("  Add User",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: Constants.popins)),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddUser(),
                      ),
                    );
                  }),
              PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.switch_account, color: Colors.white),
                      Text("  Switch User",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: Constants.popins)),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SwitchUser(),
                      ),
                    );
                  }),
              PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined, color: Colors.white),
                      Text("  Log Out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: Constants.popins)),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('userid', 0);
                    prefs.setString('token', "");
                    prefs.setString("name", "");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }),
            ],
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/images/user1.png',
                  height: 41.19,
                  width: 41.19,
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Image.asset(
                "assets/icons/menu.png",
                width: 40,
                fit: BoxFit.contain,
              ),
            ),
          );
        }),
      ),
      drawer: Drawer(
          backgroundColor: const Color(0xFF6EB7A1),
          child: SingleChildScrollView(
            child: Column(
              //padding: EdgeInsets.zero,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 120,
                  child: DrawerHeader(
                    // margin: EdgeInsets.zero,
                    //padding: EdgeInsets.symmetric(vertical: 110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              currentpage = 0;
                            });
                          },
                          child: SizedBox(
                              height: 160,
                              width: 160,
                              child: Image.asset(
                                "assets/images/RMLogowhite.png",
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 40,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "WELCOME",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: Constants.popinsbold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "ABC XYZ".toLowerCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: Constants.popins,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                createDrawerBodyItem(
                    path: "assets/icons/menu/report.png",
                    text: "View Report",
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 1;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/upload.png",
                    text: 'Upload Report',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 2;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/machinecomp.png",
                    text: 'Machine Comparison',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 3;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/charts.png",
                    text: 'Charts',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 4;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/machinelist.png",
                    text: 'Machine List',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 5;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/users.png",
                    text: 'Manage Users',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 6;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/meter.png",
                    text: 'Meter Reading',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 7;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/profile.png",
                    text: 'Profile',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 8;
                      });
                    }),
                createDrawerBodyItem(
                    path: "assets/icons/menu/todo.png",
                    text: 'To Do List',
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currentpage = 9;
                      });
                    }),
              ],
            ),
          )),
      // body: getPage(widget.values),
    );
  }
}
