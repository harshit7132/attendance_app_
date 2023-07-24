// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_widgets/Gradient slider.dart';


class CheckInOutScreen extends StatefulWidget {
  const CheckInOutScreen({super.key});
  @override
  _CheckInOutScreenState createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  bool isCheckedIn = false;
  DateTime? checkInTime;
  DateTime? checkOutTime;

  @override
  void initState() {
    super.initState();
    loadCheckInOutData();
  }

  Future<void> loadCheckInOutData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCheckedIn = prefs.getBool('isCheckedIn') ?? false;
      final checkInTimestamp = prefs.getInt('checkInTime');
      if (checkInTimestamp != null) {
        checkInTime = DateTime.fromMillisecondsSinceEpoch(checkInTimestamp);
      }
      final checkOutTimestamp = prefs.getInt('checkOutTime');
      if (checkOutTimestamp != null) {
        checkOutTime = DateTime.fromMillisecondsSinceEpoch(checkOutTimestamp);
      }
    });
  }


  Future<void> saveCheckInOutData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCheckedIn', isCheckedIn);
    await prefs.setInt('checkInTime', checkInTime?.millisecondsSinceEpoch ?? 0);
    await prefs.setInt('checkOutTime', checkOutTime?.millisecondsSinceEpoch ?? 0);
  }

  void checkIn() {
    setState(() {
      isCheckedIn = true;
      checkInTime = DateTime.now();
      saveCheckInOutData();
    });
  }

  void checkOut() {
    setState(() {
      isCheckedIn = false;
      checkOutTime = DateTime.now();
      saveCheckInOutData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In/Check-Out'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCheckedIn ? 'Checked In' : 'Checked Out',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            if (isCheckedIn)
              Column(
                children: [
                  const Text(
                    'Check-in time:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    checkInTime.toString(),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            if (!isCheckedIn && checkOutTime != null)
              Column(
                children: [
                  const Text(
                    'Check-out time:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    checkOutTime.toString(),
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            const SizedBox(height: 40.0),
            GradientSlideToAct(
              text: isCheckedIn ? 'Check-Out' : 'Check-In',
              onSlideCompleted: isCheckedIn ? checkOut : checkIn,
              gradientColors: const [Color(0xFF00F260), Color(0xFF0575E6)],
            ),
          ],
        ),
      ),
    );
  }
}