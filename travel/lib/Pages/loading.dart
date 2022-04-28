import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/Pages/home.dart';
import 'package:travel/Pages/login.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _alreadyLogged = false;

  void initLogCheck() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _alreadyLogged = sp.getBool('logged') ?? false;
    });
  }

  @override
  void initState() {
    initLogCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _alreadyLogged ? const Home() : const Login();
  }
}
