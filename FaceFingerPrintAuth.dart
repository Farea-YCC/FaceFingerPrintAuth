

import 'package:jeb_ui/auth/login.dart';
import 'package:jeb_ui/widget/CustomHeader.dart';
import 'package:jeb_ui/widget/CustomLogoutDialog.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class FaceFingerPrintAuth extends StatefulWidget {
  const FaceFingerPrintAuth({super.key});

  @override
  State<FaceFingerPrintAuth> createState() => FaceFingerPrintAuthState();
}

class FaceFingerPrintAuthState extends State<FaceFingerPrintAuth> {
  late final LocalAuthentication myauthentication;
  bool authState = false;

  @override
  void initState() {
    super.initState();
    myauthentication = LocalAuthentication();
    myauthentication.isDeviceSupported().then(
          (bool myAuth) => setState(
            () {
          authState = myAuth;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Biometrics Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: authentication,
                child: const Text(
                  "Authenticate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> authentication() async {
    try {
      bool isAuthenticate = await myauthentication.authenticate(
        localizedReason: " local authentication",
        options: const AuthenticationOptions(
          stickyAuth: true,
          // if you have choose biometricOnly to truel it not show other option to authenticate
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
    }
    if (!mounted) {
      return;
    }
  }
}