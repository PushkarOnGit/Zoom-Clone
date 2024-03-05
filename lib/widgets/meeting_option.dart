import 'package:flutter/material.dart';
import 'package:study_sync/utils/colors.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onChanged;
  const MeetingOption({
    super.key,
    required this.text,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
