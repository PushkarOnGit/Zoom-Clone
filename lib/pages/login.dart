import 'package:flutter/material.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          SizedBox(height: 10,),
          
          Icon(Icons.school_outlined, size: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Study',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 52),
                ),
              ),

              SizedBox(height: 10,),

              Text(
                'Sync',
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Colors.lightBlue, fontSize: 52)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png', height: 300,),
          ),
          Button(text: "Google Sign-in", onPressed: () async{
            bool res = await _authMethods.signInWithGoogle(context);
            if (res) {
              Navigator.pushNamed(context, '/home');
            }
          },)
        ],
      ),
    );
  }
}
