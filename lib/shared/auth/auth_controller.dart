import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _user = user;
      saveUser(user);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage() ));
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJSON());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final userJson = instance.getString("user") as String;
      setUser(context, UserModel.fromJson(userJson));
      return;
    } else {
      setUser(context, null);
    }
  }
}
