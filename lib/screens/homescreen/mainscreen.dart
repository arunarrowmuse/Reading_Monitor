import 'package:flutter/material.dart';
import 'Drawer/drawer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
        // decoration: (
        //     BoxDecoration(
        //         image: const DecorationImage(
        //           repeat: ImageRepeat.repeat,
        //           image: AssetImage('assets/images/Bg2.png'),
        //           fit: BoxFit.cover,
        //         ),
        //         border:  Border.all(),
        //         borderRadius: BorderRadius.circular(20)
        //     )
        // ),
        child: Scaffold(
      // backgroundColor: Colors.transparent,
      // drawer: NavigationDrawer(),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: <Widget>[
      //     GestureDetector(
      //       onTap: () {},
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 15.0),
      //         child: ClipRRect(
      //           child: Image.asset(
      //             'assets/images/user1.png',
      //             height: 41.19,
      //             width: 41.19,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      //   elevation: 0,
      //   leading: Builder(builder: (context) {
      //     return IconButton(
      //       iconSize: 41.19,
      //       icon: const Icon(Icons.menu_outlined),
      //       color: Colors.green,
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //     );
      //   }),
      // ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, 'HomePage');
          },
          child: ClipRRect(
            child: Image.asset(
              'assets/images/RmLogo.png',
              // height: 64,
              // width: 302,
            ),
          ),
        ),
      ),
    ));
  }
}
