import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class First_app extends StatefulWidget {
  const First_app({super.key});

  @override
  State<First_app> createState() => _First_appState();
}

class _First_appState extends State<First_app> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_supportState)
              Text('This devise is supported')
            else
              Text('This devise is not supported'),
            Divider(height: 100),
            ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: Text('Get available biometrics'))
          ],
        ),
      ),
    );
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("List of available : $availableBiometrics");

    if (!mounted) {
      return;
    }
  }
}
