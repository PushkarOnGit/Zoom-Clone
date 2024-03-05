import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_sync/resources/jitsi_meet_methods.dart';
import 'package:study_sync/utils/colors.dart';
import 'package:study_sync/widgets/home_meet_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final jitsiMeeting _jitsimeet = jitsiMeeting();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(1000000000) + 1000000000).toString();
    _jitsimeet.createMeeting(
      roomName: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join and Study"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetButton(
              onPressed: createNewMeeting,
              icon: Icons.videocam,
              text: "New Room",
            ),
            HomeMeetButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: "Join Room",
            ),
            HomeMeetButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scheduleScreen');
              },
              icon: Icons.calendar_today,
              text: "Schedule",
            ),
            HomeMeetButton(
              onPressed: () => showScreenShareOption(context),
              icon: Icons.arrow_upward,
              text: "Share Screen",
            ),
          ],
        ),
        const Expanded(
            child: Center(
          child: Text(
            "Create or Join a Study Room!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ))
      ]),
    );
  }

  showScreenShareOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: const Text(
              "Screen Share",
              textAlign: TextAlign.center,
              style: TextStyle(
                backgroundColor: backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            content: const Text(
              "You will have to join meeting for sharing your screen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
