import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:study_sync/resources/auth_methods.dart";
import "package:study_sync/resources/jitsi_meet_methods.dart";
import "package:study_sync/utils/colors.dart";
import "package:study_sync/widgets/meeting_option.dart";

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingcontroller;
  late TextEditingController namecontroller;
  final jitsiMeeting _jitsimeet = jitsiMeeting();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void dispose() {
    super.dispose();
    meetingcontroller.dispose();
    namecontroller.dispose();
  }

  _joinMeeting() {
    _jitsimeet.createMeeting(
      roomName: meetingcontroller.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: namecontroller.text,
    );
  }

  @override
  void initState() {
    meetingcontroller = TextEditingController();
    namecontroller = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Join a Meeting",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: meetingcontroller,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: "Room ID",
              // contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextField(
            controller: namecontroller,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: "Name",
              // contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: _joinMeeting,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Join",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MeetingOption(
          text: "Turn of Audio",
          onChanged: onAudioChanged,
          value: isAudioMuted,
        ),
        MeetingOption(
          text: "Turn off Video",
          onChanged: onVideoChanged,
          value: isVideoMuted,
        ),
      ]),
    );
  }

  onAudioChanged(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoChanged(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
