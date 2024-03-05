import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void addToMeetingHistory(String meetingname) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("meetings")
          .add({
        "meetingname": meetingname,
        "createdAt": DateTime.now(),
      });
    } catch (e) {
      print("Error $e");
    }
  }

  scheduleMeeting(String room, String name, DateTime? date, TimeOfDay? time) async {
    try {
      await _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).collection("scheduled_meetings").add({
        "meetingname" : room,
        "created by" : name,
        "date & time" : Timestamp.fromDate(DateTime(date!.year, date.month, date.day, date.hour, date.minute, date.second)),
      });
    } catch (e) {
      print("Error $e");
    }
  }
}
