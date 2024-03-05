import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/resources/firebase_methods.dart';

class jitsiMeeting {
  final AuthMethods _authMethods = AuthMethods();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
     Map<String, Object> featureFlags = {};

    // Define meetings options here
    try {
      String? name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName;
      }else{
        name = username;
      }

      var options = JitsiMeetingOptions(
      serverUrl: 'https://allo.bim.land',
      roomNameOrUrl: roomName,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      userDisplayName: name,
      userEmail: _authMethods.user.email,
      featureFlags: featureFlags,
    );

    print("JitsiMeetingOptions: $options");
    
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => print("onOpened"),
        onConferenceWillJoin: (url) {
          print("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          print("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          print("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          print("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          print("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          print(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          print(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          print("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          print(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isprintvate) {
          print(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isprintvate: $isprintvate",
          );
        },
        onChatToggled: (isOpen) => print("onChatToggled: isOpen: $isOpen"),
        onClosed: () => print("onClosed"),
      ),
    );
    _firebaseMethods.addToMeetingHistory(roomName);
    } catch (e) {
      print(e);
    }
  }
}
