import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/pages/home.dart';
import 'login.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String _userId;
  bool _logged = false;

  void initLogCheck() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _logged = sp.getBool('logged') ?? false;
      _userId = sp.getString('user') ?? '';
    });
  }

  @override
  void initState() {
    initLogCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _logged ? const Home() : const Login() ;
  }
}
