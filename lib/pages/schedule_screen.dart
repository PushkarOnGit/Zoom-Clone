import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_sync/resources/auth_methods.dart';
import 'package:study_sync/resources/firebase_methods.dart';
import 'package:study_sync/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:study_sync/widgets/custom_button.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late TextEditingController roomcontroller;
  late TextEditingController namecontroller;
  final AuthMethods _authMethods = AuthMethods();

  DateTime? selectedDate = DateTime.now();
  String formatedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TimeOfDay? selectedTime = TimeOfDay.now();
  String formatedTime = "";

  scheduleMeet(BuildContext context){
    FirebaseMethods().scheduleMeeting(roomcontroller.text,
                namecontroller.text, selectedDate, selectedTime);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomcontroller = TextEditingController();
    namecontroller = TextEditingController(text: _authMethods.user.displayName);
  }

  @override
  Widget build(BuildContext context) {
    formatedTime = selectedTime!.format(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Schedule a Meeting",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: roomcontroller,
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
          customOption("Date", "Select Date", () async {
            DateTime? temp = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            setState(() {
              selectedDate = temp;
              formatedDate = DateFormat('yyyy-MM-dd').format(temp as DateTime);
            });
          }, true),
          const SizedBox(
            height: 20,
          ),
          customOption("Time", "Select Time", () async {
            TimeOfDay? temp = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            setState(() {
              selectedTime = temp;
              formatedTime = temp!.format(context);
            });
          }, false),
          const SizedBox(
            height: 20,
          ),
          Button(
            text: "Schedule",
            onPressed: () => scheduleMeet(context),
          ),
        ],
      ),
    );
  }

  Widget customOption(String text, String buttontext, onpressed, bool isDate) {
    return SizedBox(
      height: 100,
      child: Container(
        height: 60,
        color: secondaryBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onpressed,
                  style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    buttontext,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                isDate
                    ? Text(
                        formatedDate,
                        style: const TextStyle(fontSize: 16),
                      )
                    : Text(
                        formatedTime,
                        style: const TextStyle(fontSize: 16),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
