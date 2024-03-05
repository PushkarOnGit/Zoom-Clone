import 'package:flutter/material.dart';
import 'package:study_sync/pages/homescreen.dart';
import 'package:study_sync/pages/login.dart';
import 'package:study_sync/pages/schedule_screen.dart';
import 'package:study_sync/pages/video_call_screen.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBQAgp3VT0GjwoOFgreIYjIyXl2V2X9QvM",
      appId: "1:966172610343:android:a6d0f8bd9664f83fab6302",
      messagingSenderId: "966172610343",
      projectId: "studysync-18f17",
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect : A video calling app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),

      routes: {
        '/login' :(context) => const Loginscreen(),
        '/home' :(context) => const HomePage(),
        '/video-call-screen' : (context) => const VideoCallScreen(),
        '/scheduleScreen' :(context) => const ScheduleScreen(),
      },

      home: StreamBuilder(
        stream: AuthMethods().authchanges,
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: 
            CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData){
            return const HomePage();
          }
          else{
            return const Loginscreen();
          }
        },
      )
    );
  }
}




