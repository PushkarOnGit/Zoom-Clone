import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/utils/colors.dart';

class HistoryMeetingScreen extends StatefulWidget {
  HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Meetings"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore
            .collection("users")
            .doc(AuthMethods().user.uid)
            .collection("meetings")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, index) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text(
                      "Room Name : ${snapshot.data!.docs[index]["meetingname"]}",
                    ),
                    subtitle: Text(
                      "Created At : ${snapshot.data!.docs[index]["createdAt"]}",
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
