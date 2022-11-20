import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/components/new_tasks.dart';
import 'package:flutter_todolist_firebase/screens/home.dart';
import 'package:flutter_todolist_firebase/services/auth_services.dart';
import 'package:flutter_todolist_firebase/services/tasks_services.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;
  static const List<Widget> screens = [
    HomePage(),
    Center(
      child: Text('Project'),
    ),
    Center(
      child: Text('Event'),
    ),
    Center(
      child: Text('Goals'),
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Tasks",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut(context);
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ))
        ],
        // leading: IconButton(
        //     onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        //     icon: const Icon(
        //       Icons.menu_rounded,
        //       color: Colors.black,
        //     )),
      ),
      // drawer: const Drawer(
      //   child: DrawerWidget(),
      // ),
      body: SafeArea(child: screens.elementAt(selectedIndex)),
      // bottomNavigationBar: buildBottomNavigationBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   onPressed: () async {
      //     switch (selectedIndex) {
      //       case 0:
      //         print('Select Index : $selectedIndex');
      //         final DateTime now = DateTime.now();
      //         await TaskService().addTask(
      //             title: 'title',
      //             detials: 'detials',
      //             date: DateTime(now.year, now.month, now.day).toString(),
      //             isComplete: true);
      //         break;
      //       case 1:
      //         print('Select Index : $selectedIndex');
      //         break;
      //       case 2:
      //         print('Select Index : ${screens[selectedIndex]}');
      //         break;
      //       case 3:
      //         print('Select Index : $selectedIndex');
      //         break;
      //     }
      //   },
      //   elevation: 8,
      //   child: const Icon(
      //     Icons.add_rounded,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          _addNewTask();
        },
        elevation: 8,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void _addNewTask() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        builder: (_) => const NewTask());
  }

  // Widget buildBottomNavigationBar() {
  //   return Container(
  //     height: 80,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           offset: const Offset(0, 4),
  //           color: Colors.black.withOpacity(0.38),
  //           blurRadius: 8,
  //         )
  //       ],
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     selectedIndex = 0;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   Icons.home_rounded,
  //                   size: 30,
  //                   color: selectedIndex == 0 ? primaryColor : customGreyColor,
  //                 )),
  //             const SizedBox(width: 30),
  //             IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     selectedIndex = 1;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   Icons.category_rounded,
  //                   size: 30,
  //                   color: selectedIndex == 1 ? primaryColor : customGreyColor,
  //                 )),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     selectedIndex = 2;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   Icons.event_rounded,
  //                   size: 30,
  //                   color: selectedIndex == 2 ? primaryColor : customGreyColor,
  //                 )),
  //             const SizedBox(width: 30),
  //             IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     selectedIndex = 3;
  //                   });
  //                 },
  //                 icon: Icon(
  //                   Icons.person_rounded,
  //                   size: 30,
  //                   color: selectedIndex == 3 ? primaryColor : customGreyColor,
  //                 )),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
