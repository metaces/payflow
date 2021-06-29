import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';

import 'app_widget.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
                child: Text(
              "Não foi possível inicializar o firebase",
              textDirection: TextDirection.ltr,
            )),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }
}
