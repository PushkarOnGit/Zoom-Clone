import 'package:flutter/material.dart';
import 'package:study_sync/pages/history_meeting_screen.dart';
import 'package:study_sync/pages/meeting_screen.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/utils/colors.dart';
import 'package:study_sync/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  OnPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    HistoryMeetingScreen(),
    // const ContactsScreen(),
    Scaffold(
        appBar: AppBar(
          title: const Text("Meet and Chat"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        body: Center(
          child:
              Button(text: "Log Out", onPressed: () => AuthMethods().signOut()),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: OnPageChanged,
          currentIndex: _page,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.comment_bank,
                size: 32,
              ),
              label: "Meet and Study",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.lock_clock,
                size: 32,
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                size: 32,
              ),
              label: "Settings",
            ),
          ]),
    );
  }
}
